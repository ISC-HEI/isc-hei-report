# Building and deployment notes 
How to to build locally and deploy to Typst app and Typst templates. Since v0.2.0, it is now based on [`justbuild`](https://github.com/just-buildsystem/justbuild)

## Image quantization
To reduce the size of images, which is nice for reducing the template size.

```bash
pngquant *.png --ext .png --force
```

# Updating this template and deploying to Typst universe

For local testing and development, once the step above has been done, you can simply build from the `template` directory using `typst watch report.typ`

When sufficiently confident that it seems to work, it's time to test a `preview` version as created by `typst`.

To build, test and deploy new releases I'm using [Just](https://github.com/casey/just).

## Preparing env
Run `script/setup`

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

## Deploying to Typst universe

- Clone the `Typst universe repos`, and `just package DEST/packages/preview`. 
- Do not forget to add a proper `.gitignore` to remove all PDFs
- Lint for kebab-case only
- Create PR as usual. A template creates automatically the PR text with update etc... If changes are required by CI/CD, push to local repository. It updates the PR automatically.
