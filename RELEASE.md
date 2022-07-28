# Release process for a new version of the CF conventions

### 1. Documents

* Check that the version (e.g. `1.10`) in `cf-conventions.adoc` is correct.
* Set the release date in `cf-conventions.adoc`.
* Check that the version in `conformance.adoc` is correct.
* Check that the history in `history.adoc` is up to date. Every Pull
  Request merged to the convention document should be
  referenced. Check that all merged Pull Requests that contributed to
  the new version have the appropriate GitHub Milestone attached to
  them.


### 2. Repository

When all Pull Requests have been merged:

* Tag the `main` branch with the new version (e.g. `v1.10.0`).
* Create a new "Latest release" that contains a link to the Pull
  Requests that contributed to the new version. Include a link to the
  contributing the Pull Requests labelled with the appropriate GitHub
  milestone. *Note: It is possible to combine these two items whilst
  setting up the new latest release in GitHub.)*
* Get the new documents from the Artefacts of the latest GitHub Actions:
  * `cf-conventions.html`
  * `cf-conventions.pdf`
  * `images/*`
  * `conformance.html`
  * `conformance.pdf`

### 3. Set new draft version

* Set the new *next* version in `cf-conventions.adoc`, and change the
  release date to "draft"
* Set the new *next* version in `conformance.adoc`.

## Move to the cf-convention.github.io repository

### 4. At cf-convention.github.io, add the release documents

* Commit the new release documents into the `Data` folder as follows:
  * `Data/cf-conventions/cf-conventions-<vn>/cf-conventions.html`
  * `Data/cf-conventions/cf-conventions-<vn>/cf-conventions.pdf`
  * `Data/cf-conventions/cf-conventions-<vn>/images/*`
  * `Data/cf-documents/requirements-recommendations/conformance-<vn>.html`
     
   where `<vn>` is replaced with the new version (e.g. `1.10`). Ensure
   that the PDF file is not stored with LFS. These documents are
   available as Artefacts from the latest GitHub Actions run in the
   cf-conventions repository.

### 5. At cf-convention.github.io, update website links and headings for the new version

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
  announce the release on `cf-convention/discuss/issues`. There may
  already be a open issue in which to do this.
