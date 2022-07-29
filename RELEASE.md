# Release process for a new version of the CF conventions
Complete the following steps in the order presented.

## Documents

* Check that the version (e.g. `1.10`) in `cf-conventions.adoc` is correct.
* Set the release date in `cf-conventions.adoc`.
* Check that the version in `conformance.adoc` is correct.
* Check that all merged Pull Requests that contributed to the new
  version have the correct GitHub Milestone
  (https://github.com/cf-convention/cf-conventions/milestones)
  attached to them - the milestone has the same name as the new
  version (e.g. `1.10`).

* Check that the history in `history.adoc` is up to date. Every Pull
  Request merged to the convention document should be referenced.

### 2. Repository

* Tag the master branch with the new version (e.g. `v1.10.0`).

* Create a new "Latest release" that contains a link to the Pull
  Requests that contributed to the new version:
  https://github.com/cf-convention/cf-conventions/releases. Include a
  link to the list of contributing the Pull Requests that are labelled
  with the new version's GitHub milestone. This link is found via
  https://github.com/cf-convention/cf-conventions/milestones, from
  where you select the version, and then view the "Closed" items.

(It is possible to combine these two items whilst setting up the new
latest release in GitHub.)

* Get the new documents from the Artefacts of the latest GitHub Actions:
  * `cf-conventions.html`
  * `cf-conventions.pdf`
  * `images/*`
  * `conformance.html`
  * `conformance.pdf`

## Set new draft version
* Set the new *next* version in `cf-conventions.adoc`, and change the
  release date to "draft"
* Set the new *next* version in `conformance.adoc`.

## Move to the https://github.com/cf-convention/cf-convention.github.io repository

### 4. At cf-convention.github.io, add the release documents

* Commit the new release documents into the `Data` folder as follows:
   
  * `Data/cf-conventions/cf-conventions-<vn>/cf-conventions.html`
  * `Data/cf-conventions/cf-conventions-<vn>/cf-conventions.pdf`
  * `Data/cf-conventions/cf-conventions-<vn>/images/*`
  * `Data/cf-documents/requirements-recommendations/conformance-<vn>.html`

* Ensure that the PDF file is not stored with LFS. These documents are
   available as Artefacts from the latest GitHub Actions run in the
   cf-conventions repository.

## At cf-convention.github.io, update website links and headings for the new version

* The following files need updating (although be aware that changes
  to the web site may introduce new links in other files, in which
  case this list should be updated as part of the release):
   * `documents.md`
   * `faq.md`
   * `latest.md`
   * `requirements-and-recommendations.md`
   * `software.md`
 
## Announce the release

* Wait until all changes are visible via the web site, and then
  announce the release on the `discuss` repo issue tracker:
  https://github.com/cf-convention/discuss/issues/new. (Note: There
  may already be a open issue in which to do this.)
