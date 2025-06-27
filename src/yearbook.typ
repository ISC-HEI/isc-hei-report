// Sert à générer le résumé pour le year book comme sur https://www.bfh.ch/dam/jcr:e512ae31-a3ed-4b65-b589-870383d794b0/abschlussarbeiten-bsc-informatik.pdf

#import "@preview/isc-hei-report:0.3.1" : *

#let doc_language = "fr" // Valid values are en, fr

#show: project.with(
  title: "Rapport de projet pour la filière ISC",
  sub-title: [Avec une mise en page `Typst`],
  course-name: "101.1 Programmation impérative",
  course-supervisor: "Prof. Dr P.-A. Mudry",
  semester: "Semestre de printemps",
  academic-year: "2025-2026",
  cover-image: image("figs/cover_image_placeholder.png"),
  cover-image-height: 8cm, // Default value = 10cm
  cover-image-caption: [A KNN graph -- Inspired by _Marcus Volg_],
  authors: ("D. Knuth", "L. Torvalds", "M. Odersky",),  
  logo: image("figs/isc_logo.svg"),
  date: datetime(year: 2025, month: 6, day: 24), // or datetime.today()
  language: doc_language, // Please change the value above
  version: [Using template 0.3.1],
  code-theme: "bluloco-light",
)

// Let's get started folks!

// Moi à entrer
Left ou right

// Eux à entrer
Photo format 35x45 (rapport 7:9)
Email permanente
Numéro de téléphon
Nom de l'étudiant
Nom de l'expert
Nom de filière, vertiefung
Lien vidéo

2 images max


== Summary (500 charactères )
An authentication protocol for the new SwissPass version was developed that extends the FIDO2 protocol with an Attribute Provider. After authentication, the attributes of the SwissPass holder are available to Relying Parties. This relieves them of attribute management responsibilities and eliminates the tedious onboarding process. The result is a simplified authentication process that improves user privacy and friendliness while retaining the security features of FIDO2.

Beim Einsatz persönlicher Geräte für elektronische Abstimmungen bieten bestehende kryptographische Protokolle nicht genügend Schutz von Brüchen des Stimmgeheiminisses. Dank eines völlig neuen Ansatzes können aber die Schwachstellen solcher Geräte beseitigt und somit die Möglichkeiten eines Angreifers eingeschränkt werden. In dieser Bachelorarbeit wurde ein erstes Implementierungskonzept dieser Lösung entwickelt, welches die Durchfüh-rung eines Wahlereignises ermöglicht.

== Objectives

== Explanation

== Conclusion / Benefits 

Must fit on one page when rendered !

// This is the end !