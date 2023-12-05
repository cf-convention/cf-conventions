# Release process for a new version of the CF conventions


Complete the following steps in the order presented.

### Warning

Be aware that elements of the https://github.com/cf-convention/cf-conventions and https://github.com/cf-convention/cf-convention.github.io repositories may have changed since the previous release, requiring modification to the release procedure. In this case, make a note of the changes and update these instructions after completing the release.

## Move to the https://github.com/cf-convention/cf-conventions repository

* Check that all merged pull requests that contributed to the new version have the correct GitHub Milestone (https://github.com/cf-convention/cf-conventions/milestones) attached to them - the milestone has the same name as the new version (e.g. `1.11`).

* Update the revision history in `history.adoc`

  - Check that the history is up to date. Every pull request merged to the convention document should be referenced.
  - Change the `Working version (most recent first)` heading to `Version <VN> (<DD MONTH YYY>)` (replacing `<VN>` with the current version, and `<DD MONTH YYY>` with today's date, e.g. `Version 1.11 (05 December 2023)`).

* Create a new release at https://github.com/cf-convention/cf-conventions/releases by following the instructions at https://docs.github.com/en/repositories/releasing-projects-on-github/automatically-generated-release-notes, with the following details:

  - "Choose a tag" for the new version on the  `main` branch: The tag should be called `v<VN>.0` (replacing `<VN>` with the current version, e.g. `v1.11.0`).
  - Set the release title to `CF-<VN>` (replacing `<VN>` with the current version, e.g. `CF-1.11`).
  - Click "Generate release notes". This will automatically generate a description of the release.
  - Edit the description to remove the list of contributors, instead adding any new people who have made substantive contributions to the list at http://cfconventions.org/conventions_contributors.html.
  - Select "Set as the latest release".
  - Select "Publish release".

* Get the new documents from the "Artifacts" section of the latest run of the "Build Workflow" GitHub Action, which will be called `CF-<VN>` (where `<VN>` is thethe current version, e.g. `CF-1.11`) at https://github.com/cf-convention/cf-conventions/actions, saving them locally:

  - `conformance_docs.zip`
  - `conventions_docs.zip`

* Unzip the downloaded artifacts to get the HTML and PDF builds of the conventions and conformance documents, and  the `images` directory. These will be used in the next section.

  - `conformance.html`
  - `conformance.pdf`
  - `cf-conventions.html`
  - `cf-conventions.pdf`
  - `images/`

* Increment the version in `version.adoc` (which records the _next_ release).

* Update the revision history in `history.adoc`, again:

  - Reinstate the `=== Working version (most recent first)` heading at the top. This is required for the new draft release of the _next_ version.

## Move to the https://github.com/cf-convention/cf-convention.github.io repository

### Add the release documents

* Add the new release documents (that have been downloaded and unpacked from the GitHub actions, see the previous section) into the `Data` folder as follows (replacing `<VN>` with the current version, e.g. `1.11`):
   
  - `Data/cf-conventions/cf-conventions-<VN>/cf-conventions.html`
  - `Data/cf-conventions/cf-conventions-<VN>/cf-conventions.pdf`
  - `Data/cf-conventions/cf-conventions-<VN>/images/*`
  - `Data/cf-documents/requirements-recommendations/conformance-<VN>.html`
  - `Data/cf-documents/requirements-recommendations/conformance-<VN>.pdf`

### Update website links and headings for the new version

* The following files need updating:

  * conventions_contributors.md
    - Add any new contributors (see the above note in "Create a new release").

  * `conventions.md`
    - Add a new HTML entry for the new version of the conventions documents
    - Increment the draft version of the conventions documents.
    - Remove the "latest released version" text from the previous latest release.
    - Add a new HTML entry for the new version of the conformance document
    - Increment the draft version of the conformance documents.
     
  * `documents.md`
  * `faq.md`
    - Update CF version number.
    
  * `index.md`
    - Update CF version number.

  * `software.md`
    - Update CF version number.

* Check for any other occurences of hard-wired version numbers in any file.

## Announce the release

* Wait until all changes are visible via the web site, and then announce the release on the `discuss` repository issue tracker: https://github.com/cf-convention/discuss/issues (note that there may already be a open issue in which to do this.
