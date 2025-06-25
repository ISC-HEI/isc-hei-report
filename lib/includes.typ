// Fancy pretty print with line numbers and stuff
#import "@preview/codelst:2.0.2": sourcecode

// Nice color boxes
#import "@preview/showybox:2.0.3": showybox

// Custom date format
#import "@preview/datify:0.1.4": day-name, month-name, custom-date-format

#let global_language = state("ln", "en")
#let global_keywords = state("kw", ())
#let header_footers_enabled = state("header_footers_enabled", false)