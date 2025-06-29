#import "../includes.typ" as inc
#import "/isc_templates.typ" as isc

#let cover_page(
  title: "Life, the Universe and Everything",
  summary: "",
  language: none, // Valid values are en, fr
  authors: "Stormy Peters",
  picture: none, // [Optional], put none if not used
  permanent-email: "", // [Optional], put none if not used
  supervisors: "",
  expert: "Dr Grace Hopper", // Optional, use none if not needed
  academic-year: "2025-2026", // Optional, use none if not needed
  is-executive-summary: true, // This is an executive summary, not a full thesis
  school: "Haute École d'Ingénierie de Sion",
  programme: "Informatique et Systèmes de communication (ISC)",
  keywords: ("engineering", "data", "machine learning", "meteorology"), // Some keywords related to your thesis
  major: "Data engineering", // "Software engineering", "Networks and systems", "Embedded systems", "Computer security", "Data engineering""
  bind-left: true, // Bind the left side of the page
  font: none,
  logo: none,
) = {
  let i18n = isc.i18n.with(extra-i18n: none, language)

  // School logo
  // place(top + right, dx: -8mm, dy: 10mm, image("../assets/hei_logo.svg", width: 180pt))

  let colon = if language == "fr" { " : " } else { ": " }
  set text(font: font, size: 9pt)

  // Title etc.
  stack(
    text(title, size: 24pt, weight: "bold"),
    v(1em),
    // Author
    text(authors + " | " + permanent-email, size: 14pt),
    v(3em),
    stack(spacing: 1em, if (supervisors != none) {
      text(i18n("programme-title")) + text(colon + programme + " | " + major, style: "italic")
      linebreak()

      if type(supervisors) != array {
        text(i18n("supervising-examiner") + colon + supervisors)
      } else {
        text(i18n("supervising-examiner") + colon + supervisors.first())
        if (supervisors.len() > 1) {
          linebreak()
          text(i18n("supervising-second-examiner") + colon + supervisors.at(1))
        }
        if expert != none {
          linebreak()
          text(i18n("supervising-expert") + colon + expert)
        }
      }
    }, v(1em), line(start: (0pt, 0pt), length: 25pt, stroke: 1mm), v(1em)),
  )

  // // University name text
  // place(right + bottom, dx: -16mm, dy: -25mm, box(align(left, stack(
  //   line(start: (0pt, 0pt), length: 3cm, stroke: 0.6mm),
  //   v(3mm),
  //   text(i18n("hes-so"), size: 12pt, weight: "bold"),
  //   v(2mm),
  //   text(i18n("faculty"), size: 12pt),
  //   v(2mm),
  //   text(school, size: 12pt),
  // ))))

  if (summary.len() == 0) {
    panic("You must provide a summary for the executive summary cover page.")
  }

  if (summary.len() > 500) {
    panic("The summary must be less than 500 characters long.")
  }

  text(summary, fill: color.rgb("#d41367"), size: 14pt)

  v(1em)

  let insert-picture(picture) = {
    if picture != none {
      place(
        right,
        float: false,        
        dx: 0mm,
        dy: 0mm,
        clearance: 1em,
        // Put it in a box to be resized
        stack(spacing: 0.5em, box(height: 3.5cm, picture), authors),
      )
    }
  }

  // place(right + bottom, dx: -16mm, dy: -25mm, box(align(left, stack(
  //   image(picture, width: 35mm, height: 45mm, style: "rounded"), // Use a picture if provided
  //   line(start: (0pt, 0pt), length: 3cm, stroke: 0.6mm),
  //   v(3mm),
  //   text(i18n("hes-so"), size: 12pt, weight: "bold"),
  //   v(2mm),
  //   text(i18n("faculty"), size: 12pt),
  //   v(2mm),
  //   text(school, size: 12pt),
  // ))) )
  //
  //

  // TODO: Complete the QR
  // insert-qr("http://www.google.com")

  // insert-picture(picture)
}