This repository contains the official source of the CF metadata conventions.
The source files are built into HTML automatically when changes are merged into this repository.
The latest build of the specification is held in the `gh-pages` branch and can be seen [here](https://cfconventions.org/cf-conventions/cf-conventions.html).

For the official web site please visit: https://cfconventions.org and the [corresponding GitHub organisation](https://github.com/cf-convention).

# Contributing to the CF Conventions

The CF Conventions are changed by changing the source files in this repository.
The rules for doing this are set forth on the [CF website](https://cfconventions.org/rules.html).
Their implementation in GitHub is described in this repository's [CONTRIBUTING.md file](https://github.com/cf-convention/cf-conventions/blob/master/CONTRIBUTING.md).

# Building the HTML

To convert the AsciiDoc files into the resulting HTML file:

1. Ensure you have [Ruby](https://www.ruby-lang.org/) installed (e.g. `sudo apt install ruby`)
1. Ensure you have a recent version of [Asciidoctor](https://asciidoctor.org/) installed (e.g. `gem install asciidoctor`)
1. Ensure you have [Make](https://www.gnu.org/software/make/) installed (e.g. `sudo apt install make`)
1. Get hold of the AsciiDoc files in this repo (e.g. `git clone git@github.com:cf-convention/cf-conventions.git`)
1. There are different options to make the conventions and conformance documents:
   - (All, the default) HTML and PDF conventions and conformance documents: 
      `make` or `make all`
   - HTML conventions and conformance documents: 
      `make html`
   - PDF conventions and conformance documents: 
      `make pdf`
   - Conventions documents (HTML and PDF): 
      `make conventions`
   - Conformance documents (HTML and PDF): 
      `make conformance`
   - Delete documents and build directories:
      `make clean`
   - Build with FINAL tag and date stamp (remember to update version in `version.adoc` file ):
      `make CF_FINAL=True`

Both HTML documents are build with images embeded into the `.html` file.

The build documents will be rendered into local paths:
  - `conventions_build/cf-conventions.html`
  - `conventions_build/cf-conventions.pdf`
  - `conformance_build/conformance.html`
  - `conformance_build/conformance.pdf`

See the [GitHub help](https://help.github.com/) pages and plethora of other git/GitHub guides for more details on how to work with repos, forks, pull requests, etc.

## Latest Spec Build

Whenever a [pull request](https://github.com/cf-convention/cf-conventions/pulls) is merged, a [travis-ci build](https://travis-ci.org/github/cf-convention/cf-conventions) generates the latest specification draft and adds it to the [gh-pages branch here](https://github.com/cf-convention/cf-conventions/tree/gh-pages).
The gh-pages branch is deployed to github pages at the following documents:
- https://cfconventions.org/cf-conventions/cf-conventions.html
- https://cfconventions.org/cf-conventions/cf-conventions.pdf
- https://cfconventions.org/cf-conventions/conformance.html
- https://cfconventions.org/cf-conventions/conformance.pdf

These documents are linked in the cf-conventions web site. [source here](https://github.com/cf-convention/cf-convention.github.io) which is published to: https://cfconventions.org/. The latest spec documents are linked from those web pages here: https://cfconventions.org/latest.html.
