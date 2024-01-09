[![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]

This work is licensed under a
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg


# ISC report template :scroll:

This is a template for students reports for the [ISC degree programme](https://www.hevs.ch/isc) at the School of engineering in Sion.

<p align="center">
<img src="sample.png" width="35%" height="35%">
</P>

## Install and setup

Using this template requires the `typst` runtime which can be installed following the instructions from <https://github.com/typst/typst>

You can also use the online editor from <https://typst.app> as the template can be used there as well but then you're on your own.

## Installing fonts

This report template uses several fonts packaged in this repository. All those fonts are distributed under the [SIL Open Font License](https://openfontlicense.org/) which is included in this repository.

To the install the fonts in a Linux environment, simply type

```bash
source install_fonts.sh
```

from within the `fonts` directory.

## PDF images inclusion

Unfortunately, `typst` does not support PDF file types inclusion. As a temporary workaround, PDF files can be converted to SVG via `pdf2svg`.

# Usage

After modifying `report.typ`, creating a PDF is straighforward with the command

```bash
typst compile report.typ
```

Another nice possibility is of course to use a VScod[e | ium] via the `Typst LSP` plugin which enables direct compilation.

# Future changes

In the future, several things _might_ be updated, such as :

- [x] Acronyms inclusion
- [ ] Glossary inclusion
- [ ] Master thesis changes for the template
- [ ] Themes for code
- [ ] Other nice things

# Questions and help

If you need any help for installing or running those tools, do not hesitate to get in touch with its maintainer [pmudry](https://github.com/pmudry).

You can of course also propose changes using PR or raise issues if something is not clear. Have fun writing reports!