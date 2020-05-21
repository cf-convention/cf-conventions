[![Build Status](https://secure.travis-ci.org/cf-convention/cf-conventions.png)](http://travis-ci.org/cf-convention/cf-conventions)

### Status

This repository contains the official source of the CF metadata conventions. 
The source files are built into HTML automatically when changes are merged into this repository. 
The latest build of the specfication is held in the `gh-pages` branch and can be seen at: http://cfconventions.org/cf-conventions/cf-conventions.html.

For the official web site please visit: http://cfconventions.org/,
and the corresponding GitHub organisation: https://github.com/cf-convention.

### Building the HTML

To convert the AsciiDoc files into the resulting HTML file:

1. Ensure you have [Ruby](https://www.ruby-lang.org/) installed (e.g. `sudo apt-get install ruby`)
2. Ensure you have a recent version of [Asciidoctor](http://asciidoctor.org/) installed (e.g. `gem install asciidoctor`)
3. Get hold of the AsciiDoc files in this repo (e.g. `git clone git@github.com:cf-metadata/cf-conventions.git`)
4. Build the HTML: `asciidoctor cf-conventions.adoc`

See the [GitHub help](https://help.github.com/) pages and plethora of other git/GitHub guides for more details on how to work with repos, forks, pull requests, etc.

### Latest Spec Build

Whenever a [pull request](https://github.com/cf-convention/cf-conventions/pulls) is merged, a [travis-ci build](https://travis-ci.org/github/cf-convention/cf-conventions) generates the latest specification draft and adds it to the [gh-pages branch here](https://github.com/cf-convention/cf-conventions/tree/gh-pages). The gh-pages branch is deployed to github pages at the following documents:
- http://cfconventions.org/cf-conventions/cf-conventions.html
- http://cfconventions.org/cf-conventions/cf-conventions.pdf
- http://cfconventions.org/cf-conventions/conformance.html
- http://cfconventions.org/cf-conventions/conformance.pdf 

These documents are linked in the cf-conventions web site. [source here](https://github.com/cf-convention/cf-convention.github.io) which is published to: http://cfconventions.org/. The latest spec documents are linked from those web pages here: http://cfconventions.org/latest.html. 