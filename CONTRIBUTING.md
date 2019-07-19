# Contributing to the netCDF-CF Conventions

Dear CF community member,

Thank you for taking the time to consider making a contribution to the [cf-conventions](http://cfconventions.org/).
The netCDF Climate and Forecasting conventions are a product by and for a broad community and your contribution is the key to their usefulness.

This set of guidelines provides a brief overview of the practices and procedures that should be used in fixing, updating, or adding to the conventions.
[//]: # (TODO: Get this link updated once we've gotten the "new rules" figured out)
It builds on the [rules for CF Convention changes.](http://cfconventions.org/rules.html)

As a prerequisite to this guide, please review the community's code of [conduct.](https://github.com/cf-convention/cf-conventions/blob/master/CODE_OF_CONDUCT.md)
The CF community takes great pride in respectful and collegial discourse. Any disrespectful or otherwise derogatory communication will not be tolerated.

[//]: # (If this is too hard for you, ask for help and we'll help!)

## General guidelines for using GitHub to change the CF Conventions

1. **A given proposal should be discussed as one issue.** It shouldn't fork or be superseded by another one, unless that reflects what has happened to the proposal.
This is so it is easy to trace the discussion that led to a given agreed proposal.

2. **A proposal should convey the reasoning and effect on all relevant sections of the specification.**
An overview of all actual changes and the impact the changes have on the specification should be clear.
Depending on the length and nature of the proposal, this may require different approaches as described below.

3. **In general, issues should be used for discussion of proposed changes and pull requests should be used for review of agreed upon changes.**
In other words, if the content or concept of what is being proposed needs to be vetted by the community it should be vetted in an issue.
If the proposal is non-controversial (such as a typo correction) or has been agreed to in concept in an issue, then detailed review of the text may take place in a pull request.
Practically all changes should be documented and discussed in an issue fixed in a related pull request.

4. **Use [labels](https://github.com/cf-convention/cf-conventions/labels) on issues and pull requests.**
Currently this is achieved by using an appropriate issue template when creating a [new issue](https://github.com/cf-convention/cf-conventions/issues/new/choose).

## Issues and pull requests

[//]: # (Maybe say that these guidelines are for classifying issues, and that the relevant template tells you how to handle it?)
Issues should attempt to follow the guidelines here and in the issue template as much as possible.
All new pull requests should be submitted to the master branch and will be merged or closed as soon as agreement has been reached.
Use of other branches is at the discretion of the repository administrators.
The following cases describe potential patterns of use for issues and pull requests.
[//]: # (In order of increasing complexity and necessity for review)

1. **Typo fix**:
If the change is a non-controversial fix such as a typo, no issue is required as these changes do not appear in the convention history.
A pull request with the fix can be submitted directly.
[//]: # (Do we need this line?)
Contributors not familiar with GitHub can submit issues for typos and similar issues for others to fix.

[//]: # (Probably we need PRs for maintaining the repo described here)

2. **Single section change**:
In the case of a change concerning one to a few paragraphs, an issue should be opened that describes the problem and proposed fix.
If important to the issue, the problem text should be pasted in the body of the issue and proposed fix included.
[//]: # (IMHO the optimal route, maybe reflect this)
A link to the line where the problem exists could also be included.
If the modification is non-controversial, a pull request could be opened simultaneously.
Discussion of the proposal should take place in one issue.
[//]: # (Optimally via commit keyword)
[//]: # (Is it true we do final review in the PR?)
[//]: # (Note that we mean merging to master?)
[//]: # (Probably here would be good for noting nuts and bolts of making motions, etc.)
Final review should take place in the pull request and the issue closed when the pull request is merged.
[//]: # (Stuff about moderator summaries, etc. will probably come in here later)

3. **Changes spanning multiple sections**:
If reasonable, changes concerning multiple sections should follow the pattern described for a single section change.
If explicitly listing proposed changes is not practical, general guideline 2 should be followed to document the proposal.
Depending on the nature of the proposal, interested community members can decide what the most effective tool is for development and review of specification changes.
Tools used for development of significant changes are up to those contributing and reviewing it.
Note that there is a rendered "rich-diff" view of a pull request that can be helpful for review of large contributions.

<!--
Add merge procedures.
Also where do we keep track of contributions?

So at some point a motion is made.
I guess the moderator is responsible for pinging the people and getting votes.
Also, make sure that a moderator is found in a timely fashion.

I think there should be one maintainer of the repository who does the merges.
That way nobody thinks they might be responsible but is not sure.
-->
