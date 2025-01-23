# Release procudure for a new version of CF


## Update the revision history in file **history.adoc**

  - Check that the history is up to date. Every non-trivial issue or merged pull request without an issue should be referenced.
  - Replace the line _`=== Working version (most recent first)`_ with the line `=== Version <VN> (<DATE>)`, substituting `<VN>` with the release version and `<DATE>` with the current date (e.g. `Version 1.12 (04 December 2024)`).


## Create the new documents

Go to your fork of https://github.com/cf-convention/cf-conventions and create the new documents:
```
cd ~/cf-conventions
export CF_FINAL=True
make clean
make all
```


## Copy the new documents to the website repository

Go to your fork of https://github.com/cf-convention/cf-convention.github.io, create a new branch from "main", copy the new documents into this branch and submit the changes as a puull request back to https://github.com/cf-convention/cf-convention.github.io. The following is an example of how this may be done, but other git formulations are possible:

```
# In the following, substitute <VN> for the release version

cd ~/cf-convention.github.io

git checkout main

# Make sure "main" is up to date
git pull upstream main

# Create new branch
git checkout -b new-documents-for-<VN>

# Copy the new files
mkdir -p Data/cf-conventions/cf-conventions-<VN>

cp ~/cf-conventions/build/cf-conventions.html ~/cf-convention.github.io/Data/cf-conventions/cf-conventions--<VN>/cf-conventions.html

cp ~/cf-conventions/build/cf-conventions.pdf ~/cf-convention.github.io/Data/cf-conventions/cf-conventions--<VN>/cf-conventions.pdf

cp ~/cf-conventions/build/conformance.html ~/cf-convention.github.io/Data/cf-documents/requirements-recommendations/conformance--<VN>.html

cp ~/cf-conventions/build/conformance.pdf ~/cf-convention.github.io/Data/cf-documents/requirements-recommendations/conformance-<VN>.pdf

# Commit the new files and push them to your fork's remote repository
git add ~/cf-convention.github.io/Data/cf-conventions/cf-conventions-<VN>/cf-conventions.html \
        ~/cf-convention.github.io/Data/cf-conventions/cf-conventions-<VN>/cf-conventions.pdf \
	~/cf-convention.github.io/Data/cf-documents/requirements-recommendations/conformance-<VN>.html \
	~/cf-convention.github.io/Data/cf-documents/requirements-recommendations/conformance-<VN>.pdf

git commit -a -m "New files for version <VN>"

git push origin HEAD

# Now create the pull request, and merge it into ~/cf-convention.github.io
```


## Update version number related content on the website

- In file **conventions.md**
  - Add a new HTML entry for the new versions of the conventions documents
  - Increment the draft version of the conventions documents.
  - Remove the "latest released version" text from the previous latest release.
  - Add a new HTML entry for the new versions of the conformance document
  - Increment the draft version of the conformance documents to next version after the release.

- In file **faq.md**
  - Update CF version numbers to the release version.

- In file **index.md**
  - Update CF version numbers to the release version.

- In file **software.md**
  - Update CF version numbers to the release version.


## Create a new GitHub release

- Go to https://github.com/cf-convention/cf-conventions/releases

- Follow the instructions at https://docs.github.com/en/repositories/releasing-projects-on-github/automatically-generated-release-notes, with the following details:

  - "Choose a tag" for the new version on the "main" branch: The tag should be called `v<VN>.0`, substituting `<VN>` with the release version (e.g. `v1.12.0`).
  - Set the release title to `CF-<VN>`, substituting `<VN>` the release version (e.g. `CF-1.12`).
  - Click "Generate release notes". This will automatically generate a description of the release.
  - Edit the description to remove the list of contributors, instead adding any new people who have made substantive contributions to the list at http://cfconventions.org/conventions_contributors.html.
  - Select "Set as the latest release".
  - Select "Publish release".


## Update file **CITATION.cff**

- Update the _version:_ field with the new version.

- Update the _doi:_ field in with the pre-reserved DOI.


## Update file **.zenodo.json**

- Update the _version_ field in with the new version.

- Update the *publication_date*_ field in with the date.

- Update the _files_ field with the new PDF file sizes and checksums. These must be the checksums of the actual files uploaded to https://github.com/cf-convention/cf-convention.github.io. MD5 checksums can be calculated with:

  ```
  # In the following, substitute <VN> for the release version

  cd ~/cf-convention.github.io/Data
  ls -o cf-conventions/cf-conventions-<VN>/cf-conventions.pdf
  ls -o cf-documents/requirements-recommendations/conformance-<VN>.pdf
  mdsum --digest md5 cf-conventions/cf-conventions-<VN>/cf-conventions.pdf
  mdsum --digest md5 cf-documents/requirements-recommendations/conformance-<VN>.pdf
  ```

# Post release

After the release has been completed, make the following changes to re-ininstate the draft status of the conventions for the next version after the release:

- In file **version.adoc**, change the value of the the _:version:_ field to be the next version after the release version (e.g. `1.13`)

- In file **history.adoc**, insert a new heading at the top of the section: `=== Working version (most recent first)`
