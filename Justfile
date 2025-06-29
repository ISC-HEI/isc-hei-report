root := justfile_directory()

export TYPST_ROOT := root

[private]
default:
	@just --list --unsorted

# <!-- # generate manual
# doc:
# 	typst compile docs/manual.typ docs/manual.pdf

# # run test suite
# test *args:
# 	typst-test run {{ args }}

# # update test cases
# update *args:
# 	typst-test update {{ args }} -->

[private]
symblink target theme:
  ./scripts/dev_link "{{target}}" "{{theme}}"  

# create symblink for dev report
# install-symblink: (symblink "@preview")

# create symblink for dev report
install-symblink-report: (symblink "@preview" "report")

# create symblink for dev bachelor thesis
install-symblink-bthesis: (symblink "@preview" "bachelor-thesis")

# create symblink for executive summary
install-symblink-exec-summary: (symblink "@preview" "exec-summary")

[private]
remove target:
  ./scripts/uninstall "{{target}}" "bachelor-thesis"
  ./scripts/uninstall "{{target}}" "report"
  ./scripts/uninstall "{{target}}" "executive-summary"

# uninstalls the library from the "@local" prefix
# uninstall: (remove "@local")

# uninstalls the library from the "@preview" prefix (for pre-release testing)
uninstall: (remove "@preview")

# packs the library into the specified destination folders (report and bachelor)
pack_distro target:  
  ./scripts/pack "{{target}}" "bachelor-thesis"
  ./scripts/pack "{{target}}" "report"

# packs report and bachelor into two directories, for previewing and local testing
pack_distro_preview : (pack_distro "@preview")

# creates the thumbnails from the examples
generate_thumbs:
  convert -density 150 'examples/bachelor_thesis.pdf[0]' -flatten bachelor_thesis_thumb.png
  convert -density 150 'examples/report.pdf[0]' -flatten report_thumb.png
