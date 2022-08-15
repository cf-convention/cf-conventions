# Release process for a new version of the CF conventions
Complete the following steps in the order presented.

## Documents

* Set the release date in `cf-conventions.adoc` by editing the line containing the text `Version {current-version}`

* Check that all merged Pull Requests that contributed to the new
  version have the correct GitHub Milestone
  (https://github.com/cf-convention/cf-conventions/milestones)
  attached to them - the milestone has the same name as the new
  version (e.g. `1.10`).

* Check that the history in `history.adoc` is up to date. Every Pull
  Request merged to the convention document should be referenced.

### Repository

* "Draft a new release" at https://github.com/cf-convention/cf-conventions/releases

  * "Choose a tag" for the new version on the  `main` branch (e.g. `v1.10.0`)

  * In the release description, create a link called "List of pull requests that contributed to CF-\<version\>" that points to the the list of contributing the Pull Requests that are labelled with the new version's GitHub milestone.
  This link is found via https://github.com/cf-convention/cf-conventions/milestones, from where you select the version, and then view the "Closed" items.

  * "Publish" the release, which will trigger the GitHub Actions that generate the documents to be copied over to the website repository (https://github.com/cf-convention/cf-convention.github.io)

* Get the new documents from the "Artifacts" section of the latest GitHub Actions run (https://github.com/cf-convention/cf-conventions/actions), saving them locally:

  * `cf-conventions.html`
  * `cf-conventions.pdf`
  * `images/*`
  * `conformance.html`
  * `conformance.pdf`

## Move to the https://github.com/cf-convention/cf-convention.github.io repository

### Add the release documents

* Commit the new release documents into the `Data` folder as follows:
   
  * `Data/cf-conventions/cf-conventions-<vn>/cf-conventions.html`
  * `Data/cf-conventions/cf-conventions-<vn>/cf-conventions.pdf`
  * `Data/cf-conventions/cf-conventions-<vn>/images/*`
  * `Data/cf-documents/requirements-recommendations/conformance-<vn>.html`

* Ensure that the PDF file is not stored with LFS. Note the these documents are found from the "Artifacts" seciotn of the latest GitHub Actions run in the cf-conventions repository.

### Update website links and headings for the new version

* The following files need updating (although be aware that changes to the web site may introduce new links in other files, in which case this list should be updated as part of the release):
   * `documents.md`
   * `faq.md`
   * `latest.md`
   * `requirements-and-recommendations.md`
   * `software.md`
   
## Update Conventions Contributors list
Check the issues that have been closed since the last release.
When closing an issue, the moderator will have mentioned any users whose contributions have been substantial enough to warrant addition to the [list of contributors](https://cfconventions.org/conventions_contributors.html).
Add new users who need to be mentioned to `conventions_contributors.md`.
 
## Announce the release

* Wait until all changes are visible via the web site, and then announce the release on the `discuss` repo issue tracker: https://github.com/cf-convention/discuss/issues.
  (Note: There may already be a open issue in which to do this.)
