#import "@preview/isc-hei-bthesis:0.5.0" : *

#let doc_language = "en" // Or en/de 

#show: project.with( 
  title: "Life, the Universe and Everything", 
    
  is-thesis: true,   
  split-chapters: true,
  
  thesis-supervisor: [Prof. Dr John Von Neumann], 
  thesis-co-supervisor: [Lady Ada Lovelace], // Optional
  thesis-expert: [Thesis expert],
  
  school: [Haute École d'Ingénierie de Sion], // Or HES-SO Valais-Wallis
  programme: [Informatique et Systèmes de communication],

  // Some keywords related to your thesis
  keywords: ("computer science", "data engineering", "machine learning"),
  major : "Data engineering", // "Software engineering", "Embedded systems", "Security", "something else"

  authors: "James Gosling", 

  date: datetime(year: 2025, month: 6, day: 24), // or datetime.today() 
  language: doc_language, // Or en/de if required
  version: none, // or for instance "1.0", for the version of your thesis],  
  code-theme: "bluloco-light",
) 
   
//// If using acronyms 
#import "@preview/acrostiche:0.5.2": *     
#include "acronyms.typ"

// Let's get started         
= Abstract <single_page>
The abstract of a bachelor thesis should provide a concise summary of the entire work. It typically includes:

- The context and motivation for the research.
- The main objective or research question.
- A brief description of the methodology or approach used.
- The key results or findings.
- The main conclusion or implications of the work.

The abstract should be self-contained, clear, and usually does not exceed 250–300 words. It allows readers to quickly understand the purpose and outcomes of the thesis without reading the full document.

The abstract *must* be written in both French and English.

#lorem(150)

#v(1fr)

*Keywords* : **#context global_keywords.get().join(", ")**

= Résumé <single_page>
Le résumé d’un mémoire de bachelor doit fournir un aperçu concis de l’ensemble du travail. Il inclut généralement :

- Le contexte et la motivation de la recherche.
- L’objectif principal ou la question de recherche.
- Une brève description de la méthodologie ou de l’approche utilisée.
- Les principaux résultats ou découvertes.
- La conclusion principale ou les implications du travail.

Le résumé doit être autonome, clair et ne pas dépasser habituellement 250 à 300 mots. Il permet aux lecteurs de comprendre rapidement le but et les résultats du mémoire sans lire l’intégralité du document. 

Le résumé doit être rédigé en français *et* en anglais. 

#lorem(150)

#v(1fr)

*Keywords* : #context global_keywords.get().join(", ")

= Acknowledgements <single_page>

The *Acknowledgements* section of a bachelor thesis is where you express gratitude to those who supported you during your research and writing process. It is an *OPTIONAL* section. It may include:

- Academic supervisors or advisors who provided guidance. 
- Professors or instructors who offered feedback or resources.
- Family and friends for emotional or practical support.
- Institutions or organizations that provided funding, facilities, or data.
- Anyone else who contributed significantly to your work. 
 
Keep this section concise and sincere. It is typically placed after the abstract and before the main content of your thesis.

// // // Generate the Table of Contents
#table_of_contents(doc_language, depth:1)

= Writing a thesis 
 
Writing a report is an exercise that involves both *content and form*. In this document, we aim to simplify the formatting aspect without making any assumptions about the content, specifically in the context of the ISC program#footnote[Here is how to add a footnote https://isc.hevs.ch].

The general structure of a bachelor thesis typically includes the following sections:

1. *Abstract*: A concise summary of the thesis, including the research question, methodology, results, and conclusions.
2. *Résumé*: A summary of the thesis in French.
3. *Acknowledgements*: (Optional) A section to thank those who supported the work.
4. *Table of Contents*: An organized listing of chapters and sections.
5. *Introduction*: Presents the background, motivation, objectives, and scope and plan of the thesis.
6. *State of the Art / Literature Review*: Reviews existing research and situates the thesis within the academic context. If salient in your work.
7. *Methodology*: Describes the methods, materials, and procedures used in the research / thesis.
8. *Results*: Presents the findings of the research, often with tables, figures, and analysis.
9. *Discussion*: Interprets the results, discusses implications, and relates findings to the research question.
10. *Conclusion*: Summarizes the main findings, contributions, and suggests future work.
11. *References / Bibliography*: Lists all sources cited in the thesis.
12. *Appendices*: (Optional) Contains supplementary material such as raw data, code, or additional explanations.

This structure may vary depending on the field of study, but these elements are commonly found in most bachelor theses. They are compulsory for the _ISC Bachelor thesis_.

= Introduction
Have fun #todo[writing your thesis!] and good luck with it !

#lorem(1000)

= Methodology
#lorem(800)

#lorem(800)

= Results 
#lorem(1000)

= Discussion
#lorem(1000)

= Conclusion
#lorem(1000)

#bibliography("bibliography.bib", full: true, style: "ieee")

// Include the appendix in the TOC but without numeration
#set heading(numbering: none, outlined : true)

//TODO investigate this
#let cleardoublepage() = {
  pagebreak(to: "even")  
  pagebreak()
}

#cleardoublepage()

// The appendix page
#place(center + horizon,
   [
     #set text(size:25pt)
     #i18n(doc_language, "appendix-title")
   ]
) 

// // From now on, do not number the sections and remove from general outline
// #set heading(numbering: none, outlined : true)

#pagebreak()
  
// Table of acronyms
// #print-index(title: [#i18n(doc_language, "acronym-table-title")], sorted: "up", delimiter: " : ", row-gutter: 0.7em, outlined: true)  

// // Table of figures
// #pagebreak()
// #outline(title: i18n(doc_language, "figure-table-title"),
//          depth: 1, indent: auto, 
//          target: figure.where(kind: image, numbering:"1"),
//          )  

// // Table of listings 
// #pagebreak()

#table_of_figures(doc_language)

// Including code 
// #pagebreak() 

// = #i18n(doc_language, "appendix-code-name")

// #let code_sample = read("sample.scala")

// #figure( 
//     code()[
//       #raw(code_sample, lang: "scala")
//     ],
//   caption: "Code included from the file example.scala"
// )

// #figure(
//     code()[
//       #raw(code_sample, lang: "scala")
//     ],
//   caption: "Code included from the file example.scala"
// )

// // #figure(
// //     code()[
// //       #raw(code_sample, lang: "scala")
// //     ],
// //   caption: "Code included from the file example.scala"
// // )

// // #figure(
// //     code()[
// //       #raw(code_sample, lang: "scala")
// //     ],
// //   caption: "Code included from the file example.scala"
// // )

// // #figure(
// //     code()[
// //       #raw(code_sample, lang: "scala")
// //     ],
// //   caption: "Code included from the file example.scala"
// // )

// // This is the end !