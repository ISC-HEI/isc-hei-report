#import "../includes.typ" as inc
#import "/isc_templates.typ" as isc

#let cover_page(
  title: "Life, the Universe and Everything",
  summary: "",
  content: none,
  language: none, // Valid values are en, fr
  authors: "Stormy Peters",
  picture: none, // [Optional], put none if not used
  permanent-email: "", // [Optional], put none if not used
  video-url: none, // Link to the video, if any
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

  // Make the caption for the executive summary 
  set figure(numbering: none, supplement: none)
  show figure.caption: set text(8pt) // Smaller font size
  show figure.caption: emph // Use italics
  set figure.caption(separator: " - ") // With a nice separator  

  // School logo
  // place(top + right, dx: -8mm, dy: 10mm, image("../assets/hei_logo.svg", width: 180pt))

  let colon = if language == "fr" { " : " } else { ": " }
  set text(font: font, size: 8.5pt)

  // Title etc.
  stack(
    text(title, size: 24pt, weight: "bold"),
    v(1em),
    // Author
    text(authors + " | " + permanent-email, size: 14pt),
    v(2.5em),
    stack(spacing: 1em, if (supervisors != none) {
      text(i18n("programme-title")) + text(colon + programme + " | " + major, style: "italic")
      linebreak()

      if type(supervisors) != array {
        text(i18n("supervising-examiner") + colon + supervisors, style: "italic")
      } else {
        if (supervisors.len() == 1) {
          text(i18n("supervising-examiner") + colon + text(supervisors.first(), style: "italic"))
        }
        if (supervisors.len() > 1) {
          text(i18n("supervising-examiner") + colon + text(supervisors.first(), style: "italic") + ", ")
          text(lower(i18n("supervising-second-examiner")) + colon + text(supervisors.at(1), style: "italic"))
        }
        if expert != none {
          linebreak()
          text(i18n("supervising-expert") + colon + text(expert, style: "italic"))
        }
      }
    }, 
    v(1.3em), 
    line(start: (0pt, 0pt), length: 25pt, stroke: 1mm),     
    ),
  )

  if (summary.len() == 0) {
    panic("You must provide a summary for the executive summary cover page.")
  }

  if (summary.len() > 500) {
    panic("The summary must be less than 500 characters long.")
  }

  text(summary, fill: color.rgb("#d41367"), size: 14pt)  

  // set rect(
  //   inset: 5pt,
  //   fill: rgb("#eff0f5"),
  //   width: 100%,
  // )

  set rect(
    inset: 0pt,
    stroke: none,
    fill: none,
    width: 100%
  )

  // The main content of the executive summary
  block(
    height: 1fr,
    grid(
      columns: if(picture != none){ (6fr, 1fr) } else {(1fr)}, // If no picture, use one column
      rows: (auto),
      gutter:10pt,    
      rect[#columns(2, gutter: 9pt, content)], // Put the user content    

      // The picture and author information
      [
        #{
          // Make local rule for image
          set image(
            fit: "cover",
            width: 100%,
            height: 100%
            // width: 35mm,
            // height: 45mm,
            // width: 100%,
            // height: auto
          )

          grid.cell(      
            colspan: 1,
            stack(     
              spacing: 0.5em, 
              box(
                clip: true,
                stroke: stroke(paint: color.luma(40%), thickness: .2pt, cap: "round"),
                radius: 4pt,
                picture,
                width: 27mm, // Ensure 7:9 aspect ratio
                height: 34.71mm
              ),        
              align(right)[#text(authors, size: 7pt)],
              // align(right)[#text(permanent-email, size: 7pt)],
              )
          )
        }
      ]
    ) 
  ) 

  if(video-url != none) {  
    // QR code generation
    import "@preview/tiaoma:0.3.0"

    place(
      top+right,
      float: false,        
      dx: 0mm,
      dy: 0mm,
      clearance: 0em,
      // Put it in a box to be resized
      stack(
        spacing: 0.5em,                
        tiaoma.barcode(video-url, "QRCode", options: (            
            scale: 1.0,
            fg-color: black,
            bg-color: white,
            output-options: (
              barcode-dotty-mode: false
            ),
            dot-size: 1.0,
        )),        
        align(center)[#text("Video", size: 8pt)],
      )
    )
  }
}
