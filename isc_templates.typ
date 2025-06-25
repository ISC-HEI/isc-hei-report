// Template for ISC reports at the School of engineering
// v0.5.0 - since 2024, pmudry with contributions from @LordBaryhobal, @MadeInShineA
//
// Missing features :
// - page and locations (above, under) references for figures not available yet

#import "lib/includes.typ" as inc

#let space-after-heading = 0.5em
#let chapter-font-size = 1.5em
#let global_keywords = inc.global_keywords

#let heavy_title(title) = {
  set text(size: chapter-font-size * 2, weight: 800)
  // pagebreak(to: "odd", weak: false)
  block(fill: none, inset: (x: 0pt, bottom: 2pt, top: 4em), below: space-after-heading * 2, {
    title
  })
}

#let set_header_footer(enabled) = {
  context inc.header_footers_enabled.update(enabled)
}

#let cleardoublepage() = {
  pagebreak(to: "even")
  pagebreak()
}

// Indicate that something still needs to be done
#let todo(body, fill-color: yellow.lighten(50%)) = {
  set text(black)
  box(baseline: 25%, fill: fill-color, inset: 3pt, [*TODO* #body])
}

//
// Multiple languages support
// Thanks @LordBaryhobal for the original idea
//
#let langs = json("i18n.json")

#let i18n(lang, key, extra-i18n: none) = {
  let langs = langs
  if type(extra-i18n) == dictionary {
    for (lng, keys) in extra-i18n {
      if not lng in langs {
        langs.insert(lng, (:))
      }
      langs.at(lng) += keys
    }
  }

  if not lang in langs {
    lang = "fr"
  }

  let keys = langs.at(lang)

  assert(key in keys, message: "I18n key " + str(key) + " doesn't exist")
  return keys.at(key)
}

#let make-outline(font: auto, title, ..args) = {
  {
    show heading:none
    heading(bookmarked: true, numbering: none, outlined: false)[Table of contents]
    // TODO c'est lidée pour bookmarker la table des matières mais il faut disable le reste des show rules
  }

  let title = if font == auto { title } else {
    text(font: font, title)
  }
  outline(title: {
    v(5em)
    text(size: 1.5em, weight: 700, title)
    v(3em)
  }, indent: 2em, ..args)
  pagebreak(weak: true)
}

// Make the table of contents with a given depth
#let table_of_contents(lang, depth: 2) = {
  make-outline(i18n(lang, "toc-title"), depth: depth)
}

// Generate the table of figures
#let table_of_figures(lang, depth: 1) = {
  [= #i18n(lang, "figure-table-title")]
  // make-outline(i18n(lang, "figure-table-title"), depth: depth, target: figure.where(kind: image))
  // outline(title: none, depth: 1, indent: auto,
  //         target: figure.where(kind: image))
}

/*********************************
 * Source code inclusion
 *********************************/
#let _luma-background = luma(250)

// Replace the original function by ours
#let codelst-sourcecode = inc.sourcecode

#let code = codelst-sourcecode.with(
  frame: block.with(fill: _luma-background, stroke: 0.5pt + luma(80%), radius: 3pt, inset: (x: 6pt, y: 7pt)),
  numbering: "1",
  numbers-style: (lno) => text(luma(210), size: 7pt, lno),
  numbers-step: 1,
  numbers-width: -1em,
  gutter: 1.2em,
)

/*********************************
 ** The template itself
 ********************************/
#let project(
  title: [Report title],
  sub-title: [Report sub-title],
  academic-year: [2024-2025],
  // If its a thesis
  is-thesis: false,
  split-chapters: true,
  thesis-supervisor: [Thesis supervisor],
  thesis-co-supervisor: none,
  thesis-expert: "[Thesis expert]",
  keywords: (),
  major: (),
  school: [School name],
  programme: [Informatique et Systèmes de Communication],
  // If its a report
  course-name: [Course name],
  course-supervisor: [Course supervisor],
  semester: [Semester],
  cover-image: none,
  cover-image-height: 10cm,
  cover-image-caption: [A KNN graph -- Inspired by _Marcus Volg_],
  cover-image-kind: auto,
  cover-image-supplement: auto,
  // A list of authors, separated by commas
  authors: (),
  date: none,
  logo: none,
  tables: (contents: false, figures: false, tables: false, listings: false, equations: false),
  version: "",
  language: "fr",
  extra-i18n: none,
  code-theme: "bluloco-light",
  body,
) = {
  inc.global_keywords.update(keywords)

  let i18n = i18n.with(extra-i18n: extra-i18n, language)

  // Set the document's basic properties.
  set document(author: authors, title: title, date: date, keywords: keywords)

  // Document language for hyphenation and other things
  let internal-language = language

  //
  //  Fonts
  //
  let body-font = ("Source Sans Pro", "Source Sans 3", "Libertinus Serif")
  let sans-font = ("Source Sans Pro", "Source Sans 3", "Inria Sans")
  let raw-font = "Fira Code"
  let math-font = ("Asana Math", "Fira Math")

  // Default body font
  set text(font: body-font, lang: internal-language)

  // Set other fonts
  // show math.equation: set text(font: math-font) // For math equations
  let selected-theme = "src/themes/" + code-theme + ".tmTheme"
  set raw(theme: selected-theme)
  show raw: set text(font: raw-font) // For code

  show heading: set text(font: sans-font) // For sections, sub-sections etc..

  /////////////////////////////////////////////////
  // Citation style
  /////////////////////////////////////////////////
  set cite(style: auto, form: "normal")

  /////////////////////////////////////////////////
  //  Basic pagination and typesetting
  /////////////////////////////////////////////////
  set rect(width: 100%, height: 100%, inset: 4pt)

  // Thesis specific settings
  set page(
    margin: (inside: 2.5cm, outside: 1.5cm, bottom: 2.1cm, top: 2cm), // Binding inside
    paper: "a4",
  ) if(is-thesis)

  // Report specific settings
  set page(
    margin: (inside: 2.5cm, outside: 2cm, y: 2.1cm), // Binding inside
    paper: "a4",
  ) if(not is-thesis)

  if(not is-thesis) {
    // For reports, we want to put the header and footer on all pages
    set_header_footer(true)
  } else {
    // For theses, we want to put the header and footer only on the first page
    set_header_footer(false)
  }

  show heading: it => {
    // In a thesis
    // Put chapters begin on odd pages
    // Add the header in a block to make space around it
    if it.level == 1 and is-thesis and split-chapters {
      set text(font: sans-font, size: chapter-font-size, weight: 800)
      pagebreak(to: "odd", weak: false)
      block(fill: none, inset: (x: 0pt, bottom: 2pt, top: 1em), below: space-after-heading * 2, if (it.numbering != none) {
        // If the heading has a numbering, display it
        i18n("chapter-title") + " " + counter(heading).display() + " " + it.body
      } else {
        // Otherwise just display the body
        it
      })
    } else {
      it
    }
  }

  // show heading.where(label: <single_page>): it => {
  //   it.numbering = none
  //   set heading(numbering: none, outlined: false)
  //   set text(font: sans-font, size: chapter-font-size, weight: 800)
  //   pagebreak(to: "odd", weak: false)
  //   block(fill: none, inset: (x: 0pt, bottom: 2pt, top: 5em), below: space-after-heading * 2, if (it.numbering != none) {
  //     // If the heading has a numbering, display it
  //     it.body
  //   } else {
  //     // Otherwise just display the body
  //     it
  //     v(1fr)
  //   })
  // }

  let authors-str = ()

  if type(authors) == str {
    authors = (authors,)
  }

  if authors.len() > 1 {
    authors-str = authors.join(", ")
  } else if authors.len() == 1 {
    authors-str = authors.at(0)
  } else {
    panic("No authors provided for the report")
  }

  let header-content = text(0.75em)[
    #emph(authors-str)
    #h(1fr)
    #emph(version)
  ]

  let footer-content = context text(0.75em)[
    #{
      emph(title)
      h(1fr)
      counter(page).display("1/1", both: true)
    }
  ]

  // Set header and footers
  set page(
    // For pages other than the first one
    header: context if counter(page).get().first() > 1 {
      if inc.header_footers_enabled.get() {        
        header-content  
      }
      else {
        none
      }
      
    },
    header-ascent: 40%,
    // For pages other than the first one
    footer: context if counter(page).get().first() > 1 {
      if inc.header_footers_enabled.get() {
        move(dy: 5pt, line(length: 100%, stroke: 0.5pt))
        footer-content
      } else {
        none
      }      
    },
  )

  // Links coloring
  show link: set text(ligatures: true, fill: blue)

  // Sections numbers
  set heading(numbering: "1.1.1 –") if (is-thesis)
  set heading(numbering: "1.1.1 –") if (not is-thesis)

  /////////////////////////////////////////////////
  // Handle specific captions styling
  /////////////////////////////////////////////////

  // Compute a supplement for captions as they are not to my liking
  let getSupplement(it) = {
    let f = it.func()
    if (f == image) {
      i18n("figure-name")
    } else if (f == table) {
      i18n("table-name")
    } else if (f == raw) {
      i18n("listing-name")
    } else {
      auto
    }
  }

  set figure(numbering: "1", supplement: getSupplement)

  // Make the caption like I like them
  show figure.caption: set text(9pt) // Smaller font size
  show figure.caption: emph // Use italics
  set figure.caption(separator: " - ") // With a nice separator

  show figure.caption: it => { it.counter.display() } // Used for debugging

  // Make the caption like I like them
  show figure.caption: it => context {
    if it.numbering == none {
      it.body
    } else {
      it.supplement + " " + it.counter.display() + it.separator + it.body
    }
  }

  /////////////////////////////////////////////////
  // Code related, only for inline as the
  // code block is handled by function at the top of the file
  /////////////////////////////////////////////////

  // Inline code display,
  // In a small box that retains the correct baseline.
  show raw.where(block: false): box.with(fill: _luma-background, inset: (x: 2pt, y: 0pt), outset: (y: 2pt), radius: 1pt)

  // Allow page breaks for raw figures
  show figure.where(kind: raw): set block(breakable: true)

  /////////////////////////////////////////////////
  // Our own specific commands
  /////////////////////////////////////////////////

  /////////////////////////////////////////////////
  // Let's make the template now
  /////////////////////////////////////////////////

  if (not is-thesis) {
    import "lib/pages/cover_report.typ": cover_page

    let report_cover = cover_page(
      course-supervisor: course-supervisor,
      course-name: course-name,
      font: sans-font,
      title: title,
      sub-title: sub-title,
      semester: semester,
      academic-year: academic-year,
      cover-image: cover-image,
      cover-image-height: cover-image-height,
      cover-image-caption: cover-image-caption,
      cover-image-kind: cover-image-kind,
      cover-image-supplement: cover-image-supplement,
      authors: authors,
      date: date,
      logo: logo,
      language: internal-language,
    )

    report_cover
  } else {
    import "lib/pages/cover_bachelor.typ": cover_page

    let supervisors = ()

    if (thesis-co-supervisor == none) {
      supervisors = (thesis-supervisor,)
    } else {
      supervisors = (thesis-supervisor, thesis-co-supervisor)
    }

    let report_cover = cover_page(
      supervisors: supervisors,
      font: sans-font,
      title: title,
      sub-title: sub-title,
      semester: semester,
      academic-year: academic-year,
      school: school,
      programme: programme,
      major: major,
      cover-image: cover-image,
      cover-image-height: cover-image-height,
      cover-image-caption: cover-image-caption,
      cover-image-kind: cover-image-kind,
      cover-image-supplement: cover-image-supplement,
      authors: authors-str,
      submission-date: date,
      logo: logo,
      language: internal-language,
    )

    report_cover
  }

  // --- Table of Contents ---

  let make-outline = make-outline.with(font: body-font)

  if tables != none {
    if tables.at("contents", default: false) {
      make-outline(i18n("toc-title"), depth: 2)
    }
    if tables.at("figures", default: false) {
      make-outline(i18n("figure-table-title"), target: figure.where(kind: image))
    }
    if tables.at("tables", default: false) {
      make-outline(i18n("table-table-title"), target: figure.where(kind: table))
    }
    if tables.at("listings", default: false) {
      make-outline(i18n("listing-table-title"), target: figure.where(kind: raw))
    }
    if tables.at("equations", default: false) {
      make-outline(i18n("equation-table-title"), target: math.equation.where(block: true))
    }
  }

  // Main body.
  set par(justify: true)

  body
}