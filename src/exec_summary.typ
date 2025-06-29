// Sert à générer le résumé pour le year book comme sur https://www.bfh.ch/dam/jcr:e512ae31-a3ed-4b65-b589-870383d794b0/abschlussarbeiten-bsc-informatik.pdf

#import "@preview/isc-hei-exec-summary:0.5.2" : *

#let doc_language = "fr" // Valid values are en, fr

#show: project.with(  
  title: "Life, the Universe and Everything", 
  language: doc_language, // Modify global if required, see above
  authors: "Stormy Peters", 
  picture: "figs/stormy.faces23764.web.jpg", // [Optional], put none if not used
  permanent-email: "john@doe.com", // [Optional], put none if not used

  summary: "An authentication protocol for the new SwissPass version was developed that extends the FIDO2 protocol with an Attribute Provider. After authentication, the attributes of the SwissPass holder are available to Relying Parties. This relieves them of attribute management responsibilities and eliminates the tedious onboarding process. The result is a simplified authentication process that improves user privacy and friendliness while retaining the security features of FIDO2.",

  thesis-supervisor: "Prof. Dr John von Neumann", 
  thesis-co-supervisor: "Lady Ada Lovelace", // Optional, use none if not needed
  thesis-expert: "Dr Grace Hopper", // Optional, use none if not needed
  academic-year: "2025-2026", // Optional, use none if not needed

  is-executive-summary: true, // This is an executive summary, not a full thesis  
  
  school: "Haute École d'Ingénierie de Sion", 
  programme: "Informatique et Systèmes de communication (ISC)",

  // Some keywords related to your thesis
  keywords: ("engineering", "data", "machine learning", "meteorology"),
  major : "Data engineering", // "Software engineering", "Networks and systems", "Embedded systems", "Computer security", "Data engineering""

  bind-left: true, // Bind the left side of the page
) 

// Let's get started folks!

// Regarder https://typst.app/universe/package/dashing-dept-news
// https://jonaspleyer.github.io/peace-of-posters/showcase/
// Moi à entrer

// Left ou right

// // Eux à entrer
// Photo format 35x45 (rapport 7:9)
// Email permanente
// Numéro de téléphon
// Nom de l'étudiant
// Nom de l'expert
// Nom de filière, vertiefung
// Lien sur vidéo hostée chez ISC

// 2 images max

// #place(
//   left, 
//   dx: 0cm, 
//   dy: 0cm,   
//   clearance: 0em, 
//   box(
//     width: 80%,
//     height: 8cm,
//     columns(2, 
//   [

//   )
//   )  
// )

#let text-body = {
[
== Objectives
#lorem-pars(200)

== Explanation
#lorem-pars(200)

== Conclusion / Benefits 
#lorem-pars(200)

Must fit on one page when rendered !

]
}

#set rect(
  inset: 4pt,
  fill: rgb("e4e5ea"),
  width: 100%,
)

#set text(size: 10pt)

#block(
  height: 1fr,
  grid(
    columns: (5fr, 1fr),
    rows: (auto),
    gutter: 5pt,
    rect[#columns(2, text-body)],      
    grid.cell(
      colspan: 1,
      image("figs/stormy.faces23764.web.jpg", height: auto),
    ),
  )
)

//TODO: 
// 

//#text-body

// This is the end !