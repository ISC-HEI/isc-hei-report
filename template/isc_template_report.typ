// Template for basic ISC reports
// v0.1 - mui 2023
//
// Missing features : 
// - page and locations (above, under) references for figures not available yet
// - 

// Fancy pretty print with line numbers and stuff
#import "@preview/codelst:2.0.0": sourcecode 

// Nice color boxes
#import "@preview/showybox:2.0.1": showybox

// Define our own functions
#let todo(body, fill_color: yellow) = {
  set text(black)
  box(
    fill: fill_color,
    inset: 1pt,
    [*TODO* #body],
  )
}

// The template itself
#let project(
  title: "",
  sub_title: "",
  course_name: "",  
  cover_image: none,
  cover_image_height: 10cm,
  cover_image_caption: "Cover image caption",
  title_block: "",
  authors: (),
  date: none,
  logo: none,
  version : "",
  language : "fr",
  body,
) = {

  // Set the document's basic properties.
  set document(author: authors, title: title)

  // Document language for hyphenation and other things  
  let internal_language = language

  // 
  //  Fonts
  //   
  let body-font = ("Source Sans 3", "Linux Libertine")
  let sans-font = ("Source Sans 3", "Inria Sans")
  let raw-font = "Fira Code"
  let math-font = ("Asana Math", "Fira Math")

  // Default body font
  set text(font: body-font, lang: internal_language)
  
  // Set other fonts
  // show math.equation: set text(font: math-font) // For math equations
  show raw: set text(font: raw-font) // For code
  show heading: set text(font: sans-font) // For sections, sub-sections etc..

  /////////////////////////////////////////////////
  // Citation style
  /////////////////////////////////////////////////
  set cite(style: auto, form: "normal")  

  /////////////////////////////////////////////////
  //  Basic pagination and typesetting
  /////////////////////////////////////////////////
  set page(        
    margin: (inside: 2.5cm, outside: 2cm, y: 2.1cm) // Binding inside
  )  

  let space_after_heading = 0.5em
  show heading: it => {it; v(space_after_heading)} // Space after heading
  
  let authors_str = ()

  if (authors.len() > 1){
     authors_str = authors.join(", ")
  }
  else{
     authors_str = authors.at(0)
  }

  let header_content = text(0.85em)[
    #emph(authors_str)
    #h(1fr)    
    v#version
  ]

  let footer_content = text(0.85em)[    
    #emph(title)
    #h(1fr)    
    #counter(page).display(
          "1/1",
          both: true
        )
  ]

  // Set header and footers
  set page(    
    header: locate(loc => {
      // For pages other than the first one
      if counter(page).at(loc).first() > 1 {
        header_content
      }
    }),

    header-ascent: 40%,

    footer: locate(loc => {
      // For pages other than the first one
      if counter(page).at(loc).first() > 1 [
        #line(length: 100%, stroke: 0.5pt)                
        #footer_content
      ]
    })
  )  
  
  // Links coloring
  show link: set text(ligatures: true, fill: blue)

  // Sections numbers 
  set heading(numbering: "1.1 -")

  /////////////////////////////////////////////////
  // Code related
  /////////////////////////////////////////////////

  // Inline code display
  // In a small box that retains the correct baseline.
  show raw.where(block: false): box.with(
    fill: luma(250),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )
  
  // Block code in a larger block
  // with more padding.
  show raw.where(block: true): block.with(
    fill: luma(250),
    inset: 10pt,
    radius: 3pt,
  )

  /////////////////////////////////////////////////
  // Our own specific commands
  /////////////////////////////////////////////////
  
  /////////////////////////////////////////////////
  // Let's make the template now
  /////////////////////////////////////////////////

  // Title page.
  // The page can contain a logo if you pass one with `logo: "logo.png"`.  
  if logo != none {
    //align(right, image(logo, height: 2cm))
    place(top + right,
      dx: 0mm,
      dy: -12mm,
      clearance: 0em,
      image(logo, height: 2.0cm)
    )

    let title_block_content = title_block

    place(top + left,
      dy: -2em,
      text(1em, 
        text(weight: 700, course_name) + "\n" + text(title_block_content)
      )
    )
  }

   v(10fr, weak: true)
  if cover_image != none{
    figure(image(cover_image, height: cover_image_height), caption: cover_image_caption) 
  }

  v(10fr, weak: true)

  // Main title
  set par(leading: 0.2em)
  text(font: sans-font, 2em, weight: 700, smallcaps(title))
  set par(leading: 0.65em)
  
  // Subtitle
  v(1em, weak: true)
  text(font: sans-font, 1.2em, sub_title)
  line(length: 100%)
  

  v(4em)


  // Author information on the title page
  pad(
    top: 1em,
    right: 20%,    
    grid(
      columns: 3,
      column-gutter: 3em,
      gutter: 2em,
      ..authors.map(author => align(start, text(1.1em, strong(author)))),
    ),
  )
  
  // The date
  text(1.1em, date)

  v(2.4fr)
  pagebreak()
  
  // --- Table of Contents ---
  outline(
    title: {
      v(5em)
      text(font: body-font, 1.5em, weight: 700, "Table des matières")
      v(3em)
    },
    indent: 2em,
    depth: 2
  )
  
  pagebreak()

  // Main body.
  set par(justify: true)

  body
}