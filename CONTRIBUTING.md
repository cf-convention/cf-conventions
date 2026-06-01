# Contributing to the CF conventions

Dear CF community member,

Thank you for taking the time to consider making a contribution to the [CF conventions](https://cfconventions.org/).
The conventions are produced by and for a broad community and your contribution is the key to their usefulness.

As a prerequisite to getting involved, please review the community's code of [conduct](https://github.com/cf-convention/cf-conventions?tab=coc-ov-file#contributor-code-of-conduct).
The CF community takes great pride in respectful and collegial discourse.
Any disrespectful or otherwise derogatory communication will not be tolerated.

These rules are designed to make it easy to contribute to the CF conventions and are tailored to GitHub, the platform where they are hosted.
They are intended to support your work and not to constrict you; if at any time you find them difficult to follow, please ask for help.
Your contribution is valuable and the community will be happy to give a hand.

This document is long, but it's not all immediately relevant when starting a proposal for changing the conventions, so please don't feel obliged to read it all at the outset.
The most relevant parts are about the categories of changes in the [first section](#rules), the opening paragraphs of the [section on enhancements](#enhancement_rules), its subsections on the [way the discussion is run](#conduct) and [how it reaches a conclusion](#conclusions), and the [section on correcting defects](#defect_rules).

## Contents

* [Rules for Changes to the CF Conventions](#rules)
  * [Rules for recognising contributions to the development of the CF conventions](#recognition_rules)
  * [Versions and schedule for updating the CF conventions](#new_versions)
  * [Rules for enhancements to the CF conventions and the CF standard name guidelines](#enhancement_rules)
    * [Conduct and moderation of the discussion on the GitHub issue](#conduct)
    * [The role of interactive discussions in resolving the issue](#meetings)
    * [Reaching a conclusion to the issue](#conclusions)
    * [Possible outcomes of the issue](#outcomes)
  * [Rules for maintaining consistency between the CF conventions and the CF data model](#data_model_rules)
  * [Rules for maintaining consistency between the CF and UGRID conventions](#ugrid_consistency_rules)
  * [Rules for rectifying flaws in the CF conventions](#flaw_rules)
  * [Rules for correcting defects in CF documents](#defect_rules)
  * [Dormant issues](#dormant_issues)
* [Technical guidelines](#technicalities)
  * [Pull requests](#pull_requests)
  * [Text styling](#text_styling)
  * [Infrastructure guide](#infrastructure_guide)
* [Revision history of the rules](#history)

## <a name="rules">Rules for Changes to the CF Conventions</a>

These rules apply to the CF conventions document and the conformance document.
They describe the practices and procedures that should be used in fixing, updating, or adding to the conventions.

**These rules do not apply to changes in CF standard names and other vocabularies.
The rules for changes to CF vocabularies are [here](https://cfconventions.org/standard_name_rules.html).**

All changes to the conventions documents are proposed and discussed in an [issue](https://github.com/cf-convention/cf-conventions/issues) and implemented in a related [pull request](https://github.com/cf-convention/cf-conventions/pulls) in the CF [conventions GitHub repository](https://github.com/cf-convention/cf-conventions), which contains the source of the CF conventions documents.
Changes are of three kinds:

1. Enhancements, which add new capabilities or improve existing ones. Removing or making a recommendation against an existing convention is also an enhancement, but these are very uncommon because of design principle 9 of [section 1.2](https://cfconventions.org/cf-conventions/cf-conventions.html#design). See also the [rules for rectifying flaws](#flaw_rules) in the conventions.

2. Corrections to substantial defects, when the text is unclear, or could be interpreted in a way which isn't what was intended when the convention was agreed.

3. Corrections to trivial defects, where the text contains broken links, typos, spelling mistakes, formatting errors, etc., which make the document less usable but do not cause misinterpretations.

We use [labels](https://github.com/cf-convention/cf-conventions/labels), applied when creating a new issue, to distinguish `enhancement` and `defect` changes.
Changes for enhancements (1) and substantial defects (2) are noted in the [revision history](https://cfconventions.org/cf-conventions/cf-conventions.html#revhistory) of the CF conventions document, in order to make users aware of them.
To propose such a change, please open a [new conventions issue](https://github.com/cf-convention/cf-conventions/issues/new/choose) with the right label (`enhancement` or `defect`), and follow its template.
Changes for trivial defects (3) are not noted in the revision history.
To propose such a change, include it in the existing open `defect` issue for "Trivial defects in the current working version".

The [rules for enhancements](#enhancement_rules) (1) and the [rules for defects](#defect_rules) (2 and 3) are different, as described below.

Changes to the standard name guidelines are classified as enhancements or corrections to defects, and follow the same [rules for enhancements](#enhancement_rules) and [rules for defects](#defect_rules).
Since the standard name guidelines are stored in the [CF vocabularies repository](https://github.com/cf-convention/vocabularies), `enhancement` and `defect` issues applying to the guidelines should be opened in that repository, not in the conventions repository.

----

### <a name="recognition_rules">Rules for recognising contributions to the development of the CF conventions</a>

When a change is made to the text of the conventions which is the subject of an `enhancement` issue, the individual(s) who first proposed the textual changes required should be added to the end of the list of additional authors of the CF convention.
The CF conventions committee will decide who should be named as an author in case of doubt about the application of this rule, and exceptionally it may also decide to add other individuals to the list of authors.

To recognise all significant contributions to the the development of the conventions, individuals are added to the [list of contributors](https://cfconventions.org/conventions_contributors.html).
The CF conventions committee will ensure that this list includes everyone who has contributed by proposing changes or suggesting ideas for improvement, whether as `defect` or `enhancement` issues (including authors of the conventions), or by participating substantially in discussions about the text or intent of proposed changes.

----

### <a name="new_versions">Versions and schedule for updating the CF conventions</a>

A new version of the conventions is published once a year, with the convention version number incremented.
It takes a minimum of three weeks for a change to the content of the CF conventions to be merged into the next version.
This means that the de facto "feature freeze" for a given version of the CF Conventions is three weeks before the release.
In recent years, the release has followed the year's annual CF meeting.

All versions of the standard and conformance documents are kept available online, with their GitHub issues.

----

### <a name="enhancement_rules">Rules for enhancements to the CF conventions and the CF standard name guidelines</a>

These rules apply to proposing material changes to the CF conventions or the CF standard name guidelines.
The discussion takes place in a GitHub `enhancement` issue and all may participate.
A given proposal should be discussed as one issue. It shouldn't fork or be superseded by another one, unless that reflects what has happened to the proposal.
This is so it is easy to trace the discussion that led to a given agreed proposal.

The issue should convey the content or concept of what is being proposed, with the reasoning, and its effect on all relevant sections of the CF documents.

Depending on the length and nature of the proposal, this may require different approaches.
A pull request may be opened once the discussion has reached the stage of discussing the text in detail.
Review of the textual changes may take place either in the pull request or in the issue, whichever is clearer.
For instance, it can be clearer to comment on specific wording in the context where it occurs in the pull request, but clearer to make suggestions in the issue for global changes to wording or other changes which affect several parts of the text at once. 
Comments in pull requests should not be used for discussion of the issue in general.
This is so that the conceptual development of the proposal is easily found in one place, i.e. the GitHub issue.

During the discussion, the implications of the proposal for the CF data model, and vice-versa, must be considered, following the [additional rules](#data_model_rules) for the data model.

In some cases, examples of datasets or pseudocode to illustrate the idea may be necessary to inform the discussion and give confidence that the proposal is not flawed.
By default, these are not necessary, but they must be provided by the proposer if requested during the discussion.
In case of any disagreement about the need, the conventions committee will arbitrate.

#### <a name="conduct">Conduct and moderation of the discussion on the GitHub issue</a>:

It is expected that everyone with an interest will contribute to the discussion and to achieving a consensus in the GitHub issue.
During the discussion, if an objection is raised, answered and not reasserted, it will be assumed that the objection has been dropped.
However, since consensus is the best outcome, it will be helpful if anyone who expresses an objection explicitly withdraws it on changing their mind or deciding to accept the majority view.

If the discussion needs a moderator to help it progress, any member of the conventions committee, or another suitably qualified person, may volunteer to moderate it, including the proposer (provided they are sufficiently objective and neutral).
If no-one volunteers, the chairman of the committee will ask someone to do it.

The moderator should try to keep the discussion moving forward towards a consensus.
If the discussion stalls before reaching a conclusion, the moderator should try to restart it, for instance by asking specific individuals to respond to particular points, to clarify whether they support the proposal or whether they have outstanding concerns.

#### <a name="meetings">The role of interactive discussions in resolving the issue</a>:

The moderator is encouraged to organize discussion meetings if this might help resolve an issue more quickly.
The arguments presented and any conclusions reached in such a meeting should be summarised afterwards in the GitHub issue, for the record and so that everyone can continue to be involved in further discussion.

If it proves impossible to resolve disagreements after considerable efforts by discussion on GitHub and in one-off meetings, anyone may propose on the issue that a group should be convened to meet online with the aim of reaching decisions on the issue on behalf of the community.
When this proposal is made, anyone who is concerned about the outcome of the issue should be strongly encouraged to join the group.
Everyone who wants to join must be allowed to do so, and must indicate their wish to do so within three weeks of the proposal being made to convene a group.
Every reasonable effort must be made to facilitate participation by all who wish to.
Anyone who objects to the issue being delegated to a group must state their objection within three weeks of the proposal being made to convene a group.
If there are any such objections, the conventions committee will decide by majority whether a group should be convened.

Once a group has been convened, it arranges whatever meetings it needs for its work, until it has decided (by consensus if possible, otherwise by majority) how the issue should be concluded: with proposed text, with an outline of text to be elaborated, or that no change can be agreed.
When the group has finished its work, it reports its decisions on the GitHub issue.
Thereafter, the discussion resumes on the issue as usual, except that no objections may be made to the substance of the group's decisions.
However, comments and concerns may be made about the proposed wording of changes, of the same kind as would normally be treated as defects.

#### <a name="conclusions">Reaching a conclusion to the issue</a>:

At any point when there are no outstanding concerns, and a consensus appears to be within reach, the moderator or anyone else may suggest a conclusion to the discussion, and call for any further support to be expressed, comments made or concerns stated, within the following three weeks.
The suggested conclusion should set out the exact changes to the text now proposed (following the discussion), either in the issue, or transcribed into a pull request linked to the issue; during the three weeks, a pull request should be prepared to implement any proposed changes if this has not previously been done.
Alternatively, the suggested conclusion may be that no change should be made, either because no change is necessary, or because it has not been possible to agree about any change.

If any concerns are reasserted or newly raised during the three weeks, in disagreement with the suggested conclusion, the discussion continues.

For the suggested conclusion to be accepted, at least three contributors to the discussion must have expressed support for it in its current form, including at least two members of the conventions committee. If the moderator personally expresses support, they can be counted among the supporters.
If this condition is satisfied, and no concerns are expressed within the three weeks, the discussion is concluded as suggested.

#### <a name="outcomes">Possible outcomes of the issue</a>:

If the conclusion is that no change should be made, the moderator or anyone with the necessary GitHub permissions attaches the `agreement_not_to_change` label to the GitHub issue and closes it by stating the outcome.

In this case the issue may be reopened for further discussion at a later date.

Otherwise, the proposal is accepted in the agreed form as soon as the pull request is ready, including an entry for the issue in the revision history at the end of the conventions document. The moderator or anyone with the necessary GitHub permissions attaches the `change_agreed` label to the GitHub issue, checks that the pull request is linked to the issue, merges the pull request and closes the issue by stating the outcome. It may be useful for someone other than the author of the pull request to check and merge it, to reduce the possibility of oversights, but this is not a requirement.

If subsequent discussion is required after the pull request has been merged then a new issue should be raised, rather than reopening the closed issue.

----

### <a name="data_model_rules">Rules for maintaining consistency between the CF conventions and the CF data model</a>

The CF data model ([Appendix I](https://cfconventions.org/cf-conventions/cf-conventions.html#appendix-CF-data-model)) guides the development of the CF conventions by providing a framework for ensuring that proposed changes fit into CF in a logical way, rather than just a pragmatic one.

All enhancement proposals will be assessed to see if the new features defined in the proposal map onto the CF data model.
The assessment will be carried out by a member of the conventions committee or another suitably qualified person.
If no-one volunteers, the chairman of the committee will ask someone to do it.

If the proposal maps onto the existing CF data model then no modifications to the data model are required.
Otherwise an attempt must be made to modify the proposal so that its new features do map onto the CF data model, and in such a way that the proposal's intent is not compromised.

If the proposal cannot be acceptably modified to conform to the existing data model, then the data model will need to be modified to accommodate the new features.
The preferred solution is a backwards compatible modification to the data model, whereby it is extended or generalised in some way that allows the new features but does not affect its existing constructs and relationships.

Any changes to the data model must be described verbatim as part of the proposal discussion, including any modified or new data model diagrams.
However, to facilitate the progress of a proposal that requires data model changes, it is sufficient for the general nature of the data model modifications to be identified, on the understanding that the data model text will be updated in detail at a later date, possibly after the proposal has been accepted.

----

### <a name="ugrid_consistency_rules">Rules for maintaining consistency between the CF and UGRID conventions</a>

CF incorporates named versions of the UGRID conventions without redefining them in the CF conventions document, i.e. CF formally refers to the UGRID conventions document for its description of mesh topologies.
UGRID has its own governance that is independent of the rules governing the CF conventions, and it is therefore the joint responsibility of the CF and UGRID communities to ensure that changes to one convention are mutually agreeable to the other.

In the unlikely and highly undesirable event that a non-negotiable change to one convention is incompatible with the other convention then this may be resolved either

* by restricting which versions of UGRID are allowed in CF, or

* (as a last resort) by rewriting UGRID into the CF conventions document, including any required compatibility changes, thereby breaking the formal dependence on the external UGRID conventions.

----

### <a name="flaw_rules">Rules for rectifying flaws in the CF conventions</a>

A convention is described as flawed if data written following that convention could be somehow erroneous or ambiguous.
Errors or lack of clarity in wording, when the convention itself is not at fault, are not flaws (in this sense) and can be corrected on the usual schedule following the [rules for correcting defects](#defect_rules).

If a flaw is suspected in the CF conventions, a GitHub conventions `enhancement` issue should urgently be opened to discuss the matter.
The discussion should proceed according to the usual [rules for enhancements](#enhancement_rules).
A possible conclusion is an agreement that there is no material flaw.

If it is agreed that a convention is flawed, the agreement must also include a suitable remedial change to the conventions text, to enable new data to be written which does not suffer from the flaw.

The flaw must be described in the conventions document, and a requirement added in the conventions and conformance documents that data must not be written according to the flawed convention.
If possible, guidance should be included on how any affected existing data should be treated.
It may be agreed to prepare and release a new version of the conventions immediately, including these changes, instead of waiting for the expected next release date.

Data written according to the flawed convention will not be invalidated, although it may be problematic for users.

----

### <a name="defect_rules">Rules for correcting defects in CF documents

These rules apply to correcting defects in the CF conventions and conformance documents and the standard name guidelines.

Errors in the documents can be corrected under these rules if it is clear that the text as it stands isn't what was intended. Errors are of two kinds:

* Substantial defects, when the text is unclear, or could be interpreted in a way which isn't what was intended when the convention was agreed.

* Trivial defects e.g. typographical errors, which make the document less usable but do not cause misinterpretations.

These rules can't be followed for making substantive changes, which must follow the [rules for enhancements](#enhancement_rules).

If someone thinks there is an error in a document, they should use a GitHub issue of type `defect` to point it out and to state what should be done to the text in order to correct the error.
A new `defect` issue should be opened for a substantial defect in the conventions and conformance documents, and any defect in the standard name guidelines.
Trivial defects to the conventions and conformance documents should be included it in the existing open `defect` issue for "Trivial defects in the current working version".
A corresponding GitHub pull request can also be submitted at the same time as the issue.

The correction is held to have been agreed if three weeks pass without anyone disagreeing with it.
After that period, the issue should be closed by the secretary of the CF conventions, the secretary of CF standard names or any member of the CF conventions committee, who will make the change and/or merge the pull request.
No moderator is needed because there cannot be any substantive discussion under these rules.

If anyone disagrees that the correction should be made, because they think that the document is already clear or has the intended meaning, then a correction cannot be made by these rules.
In this case the issue should be closed, and the change should be proposed as an `enhancement` instead, following the [relevant rules](#enhancement_rules), if the proposer wants to pursue the issue.

----

### <a name="dormant_issues">Dormant issues</a>

If an issue falls silent for more than six months without conclusion, any member of the conventions committee may post on the issue to encourage any interested person to resume it within three weeks, if they wish it to remain open.
If discussion does not resume within three weeks, the issue should be closed with the `dormant` label attached.
The issue may subsequently be reopened and the `dormant` label removed by anyone wishing the continue the discussion.

----

## <a name="technicalities">Technical guidelines</a>

### <a name="pull_requests">Pull requests</a>

Pull requests should be submitted to the `main` branch of the repository.
Use of other branches is at the discretion of the repository administrators.
It is recommended that pull requests are created on a branch of a personal fork of the repository.
Comments in pull requests should be avoided, unless discussing changes to the wording of a proposal that do not impact on the agreed meaning.

----

### <a name="text_styling">Text styling</a>

The CF conventions documents and website are generated from a mix of AsciiDoc and Markdown files.
The files should be formatted in line with the
[AsciiDoc Recommended Practices](https://asciidoctor.org/docs/asciidoc-recommended-practices/)
and
[Google Markdown style guide](https://google.github.io/styleguide/docguide/style.html).
Each sentence should begin on a new line.

The documents refer to the "CF conventions" like that (like the website URL), not as the "CF convention" (singular) or the "CF standard", and they are written impersonally, not as "We".

----

### <a name="infrastructure_guide">Infrastructure guide</a>

See [CF website repo issue #548](https://github.com/cf-convention/cf-convention.github.io/issues/548).

----

## <a name="history">Revision history of the rules</a>

* This document was created by merging the previous rules for enhancements and defects with the existing text of `CONTRIBUTING.md` under [GitHub issue #369](https://github.com/cf-convention/cf-conventions/issues/369).

* The rules for correcting defects were agreed under [GitHub issue #130](https://github.com/cf-convention/cf-conventions/issues/130).

* The rules were amended in January 2016 following [CF trac ticket 146](http://cfconventions.org/Data/Trac-tickets/146.html).

* The rules for changing the conventions were agreed by discussion in the [CF mailing list archives](https://cfconventions.org/mailing-list-archive/Data), in June and July 2007. See messages with the subject line "proposed rules for changes to CF conventions".
