# Contributing to the NetCDF-CF conventions

Dear CF community member,

Thank you for taking the time to consider making a contribution to the
[cf-conventions](http://cfconventions.org/).
The NetCDF Climate and Forecasting conventions are a product by and for a broad
community and your contribution is the key to their usefulness.

This set of guidelines provides a brief overview of the practices and procedures
that should be used in fixing, updating, or adding to the conventions. It builds
on the [rules for CF Convention changes.](http://cfconventions.org/rules.html)

As a prerequisite to this guide, please review the community's code of
[conduct.](https://github.com/cf-convention/cf-conventions/blob/master/CODE_OF_CONDUCT.md)
The CF community takes great pride in respectful and collegial
discourse. Any disrespectful or otherwise derogatory communication will not be
tolerated.

As of the creation of this version of these guidelines, contributions can also be
made through the [cf-trac](https://cf-trac.llnl.gov/trac/) infrastructure.
[Procedures for using trac](http://cfconventions.org/rules.html) are not covered
here and it is expected that the trac system will be deprecated once the
community is comfortable using github for this purpose.

## General Guidelines

1. **A given proposal should be discussed as one issue.** It shouldn't fork or
be superseded by another one, unless that reflects what has happened to the
proposal. This is so that it's easy to trace the discussion which led to a
given agreed proposal.

2. **A proposal should convey the reasoning and effect on all relevant
sections of the specification.** An overview of all actual changes and the
impact the changes have on the specification should be clear. Depending on the
length and nature of the proposal, this may require different approaches as
described below.

3. **In general, issues should be used for discussion of proposed changes and
pull requests should be used for review of agreed upon changes.** In other words,
if the content or concept of what is being proposed needs to be vetted by the
community it should be vetted in an issue. If the proposal is non-controversial
(such as a typo correction) or has been agreed to in concept in an issue, then
detailed review of the text may take place in a pull request.

4. **Use [labels](https://github.com/cf-convention/cf-conventions/labels) on issues 
and pull requests.** Please attempt to present contributions as enhancements, 
defects, or typos and label them accordingly. 

## Issues and Pull Requests

The following cases describe potential patterns of use for issues and pull requests.

1. **Typo Fix** If the change is a non-controversial fix such as a typo,
no issue is required. A pull request with the fix can be submitted directly.
Contributors not familiar with github can submit issues for typos and similar
issues for others to fix.

2. **Single Section Change** In the case of a change concerning one to a few
paragraphs, an issue should be opened that describes the problem and proposed
fix. The problem text should be pasted in the body of the issue and proposed fix
included. A link to the line where the problem exists could also be included.
If the modification is non-controversial, a pull request could be opened
simultaneously if the reporter is familiar with git and github. Discussion of
the proposal should take place in one issue. Once accepted, a pull request could
be submitted implementing the suggested change. Final review should take place
in the pull request and the issue closed when the pull request is merged.

3. **Changes Spanning Multiple Sections** If reasonable, changes concerning
multiple sections should follow the patter described Single Section Change.
If explicitly listing proposed changes is not practical, general guideline
2 should be followed to document the proposal. Depending on the nature of the
proposal, interested community members can decide what the most effective tool
is for development and review of specification changes. Some proposals have
been developed in google docs and contributed as a pull request after general
consensus has been reached, but the specific tools used for development of
significant changes is up to those contributing and reviewing it.
