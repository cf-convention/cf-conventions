[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.14274886.svg)](https://doi.org/10.5281/zenodo.14274886)


This repository contains the official source of the CF metadata conventions.
The source files are built into HTML automatically when changes are merged into this repository.
The latest build of the specification is held in the `gh-pages` branch and can be seen [here](https://cfconventions.org/cf-conventions/cf-conventions.html).

For the official web site please visit: https://cfconventions.org and the [corresponding GitHub organisation](https://github.com/cf-convention).

# Contributing to the CF Conventions

The CF Conventions are changed by changing the source files in this repository.
The rules for doing this are set forth on the [CF website](https://cfconventions.org/rules.html).
Their implementation in GitHub is described in this repository's [CONTRIBUTING.md file](https://github.com/cf-convention/cf-conventions/blob/master/CONTRIBUTING.md).

# Building the documentation

The following steps outline how to build the CF Conventions documentation into HTML and/or PDF format using AsciiDoc and the provided Makefile:

1. Ensure you have [Ruby](https://www.ruby-lang.org/) installed. (e.g. `sudo apt install ruby`)
2. Ensure you have a recent version of [Asciidoctor](https://asciidoctor.org/) installed (e.g. `gem install asciidoctor`)
3. Ensure you have [Make](https://www.gnu.org/software/make/) installed. (e.g. `sudo apt install make`)
4. Clone the repository containing the AsciiDoc files. (e.g. `git clone git@github.com:cf-convention/cf-conventions.git`)
5. There are different options to make the conventions and conformance documents:
   - (Default: Build all formats) HTML and PDF conventions and conformance documents: 
      `make` or `make all`
   - HTML conventions and conformance documents: 
      `make html`
   - PDF conventions and conformance documents: 
      `make pdf`
   - Conventions documents (HTML and PDF): 
      `make conventions`
   - Conformance documents (HTML and PDF): 
      `make conformance`
   - Remove built documents and clean build directories:
      `make clean`

Both HTML documents will have images embedded within `.html` file.

The built documents will be rendered in the `build` directory with the resulting paths:
  - `build/cf-conventions.html`
  - `build/cf-conventions.pdf`
  - `build/conformance.html`
  - `build/conformance.pdf`

Ensure the built documents meet your requirements before publishing.

See the [GitHub help](https://help.github.com/) pages and many other git/GitHub guides for more details on how to work with repos, forks, pull requests, etc.

## Release metadata

The file `version.adoc` acts as the single source of truth for the CF version number, canonical release date, and DOI. In particular, the following attributes are edited manually at the start of each new release
cycle:

- `version`
- `release-date-iso`
- `doi`

All other release-related attributes (such as the human-readable display date or the citation year) are either derived from these values or injected by the build system (Makefile/CI). For ad-hoc local builds without the Makefile, sensible fallbacks are provided so that the document still renders consistently.

## Build modes (DRAFT vs FINAL)

By default, builds are produced in **DRAFT** mode, which is what you get from a normal call to `make`:

~~~bash
make
~~~

To produce a build intended for publication as an **official FINAL release**, set the environment variable `DOC_STATUS` to `FINAL`:

~~~bash
DOC_STATUS=FINAL make
~~~

In FINAL mode:

- the visible release date is derived from `release-date-iso`
- the citation year used in the formal citation is fixed from the canonical release date
- timestamps and other draft-only metadata are not shown

### Advanced: Overriding the release date

Normally you should not need to override the `release-date-iso` attribute. However, for testing or exceptional cases you may explicitly set the environment variable `RELEASE_DATE_ISO` when building in `FINAL` document status:

~~~bash
DOC_STATUS=FINAL RELEASE_DATE_ISO="2026-02-16" make
~~~

Environment-provided values always take precedence over the defaults derived by the `Makefile`.

## Testing

A basic link checker is available to validate external and internal (i.e. *fragments*) links in the generated HTML documents.

To run the link check:
  - `make test-links`

This updates the HTML documents and runs `lychee` on the generated `build/cf-conventions.html` and `build/conformance.html`.

A report, for both files, is written in the `tests/lychee.md` Markdown file.

The command fails if broken links are detected.

## Optional: reproducible build environment

For convenience, a minimal `environment.yml` is provided to create a reproducible
documentation build environment using `conda`/`mamba` from the `conda-forge`
channel.

This is optional and system packages (i.e. `apt`) or `RubyGems` can also be used.

To create and activate the environment:
  - `conda env create -f environment.yml`
  - `conda activate cf-conventions-docs`

However, `asciidoctor-pdf` is not available via `conda-forge`, and must be
installed via RubyGems in the activated environment:
  - `gem install asciidoctor-pdf`

The `Makefile` checks for the required tools at build time and reports clear
errors if any dependency is missing.

## Latest Spec Build

Whenever a [pull request](https://github.com/cf-convention/cf-conventions/pulls) is merged, a [travis-ci build](https://travis-ci.org/github/cf-convention/cf-conventions) generates the latest specification draft and adds it to the [gh-pages branch here](https://github.com/cf-convention/cf-conventions/tree/gh-pages).
The gh-pages branch is deployed to github pages at the following documents:
- https://cfconventions.org/cf-conventions/cf-conventions.html
- https://cfconventions.org/cf-conventions/cf-conventions.pdf
- https://cfconventions.org/cf-conventions/conformance.html
- https://cfconventions.org/cf-conventions/conformance.pdf

These documents are linked in the cf-conventions web site. [source here](https://github.com/cf-convention/cf-convention.github.io) which is published to: https://cfconventions.org/. The latest spec documents are linked from those web pages here: https://cfconventions.org/latest.html.
