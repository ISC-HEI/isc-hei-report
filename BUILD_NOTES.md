# Building and deployment notes 
This file explains how to to build locally and deploy to Typst app and Typst templates. 

Since v0.2.0, the build process is based on [`justbuild`](https://github.com/just-buildsystem/justbuild)

## Preparing env
Run `script/setup`

:warning: If running on Mac, you might have to adapt the shell used in `scripts/package`

## Testing preview

To deploy locally in `typst`

```bash
just install-preview
```

then for example

```bash
typst init @preview/isc-hei-report:0.2.0
```

Then go the directory, try to compile with `typst watch report.typ`.

# Updating the template and deploying to Typst universe

For local testing and development, once the step above has been done, you can simply build from the `template` directory using `typst watch report.typ`

When sufficiently confident that it seems to work, it's time to test a `preview` version as created by `typst`.

To build, test and deploy new releases I'm using [Just](https://github.com/casey/just).

## Deploying to Typst universe

- Clone the `Typst universe repos`, and `just package DEST/packages/preview`. 
- Do not forget to add a proper `.gitignore` to remove all PDFs
- Lint for kebab-case only
- Create PR as usual. A template creates automatically the PR text with update etc... If changes are required by CI/CD, push to local repository. It updates the PR automatically.

## Image quantization
To reduce the size of images, which is nice for reducing the template size on the Universe.

```bash
pngquant *.png --ext .png --force
```