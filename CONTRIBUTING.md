# The Odin Project Web App Contributing Guide

Thank you for expressing interest in contributing to The Odin Project (TOP) web app! Before continuing through this guide, be sure you've read our [general contributing guide](https://github.com/TheOdinProject/.github/blob/main/CONTRIBUTING.md), as it contains information that is important for all of our repos.

This contributing guide assumes you have followed the instructions in our general contributing guide to fork and clone our web app repo.

## Table of Contents

- [How to Contribute](#how-to-contribute)
  - [Documentation-Only and Minor Contributions](#documentation-only-and-minor-contributions)
  - [Running The Odin Project Locally](#running-the-odin-project-locally)
  - [Adding Curriculum Content](#adding-curriculum-content)
  - [Testing Changes Locally](#testing-changes-locally)

## How to Contribute

Due to the complexity of our web app repo compared to some of our other repos, contributing requires you to be able to run our web app locally and to run tests to ensure any changes being made look and work as expected.

### Documentation-Only and Minor Contributions

Not all contributions to The Odin Project web app require running the application locally. We welcome documentation-only and other minor contributions that improve clarity, accuracy, and maintainability of the project.

Examples of contributions that typically do not require running the web app locally include:

-Fixing typos, grammar, or formatting

-Improving explanations or comments in documentation

-Updating or correcting links

-Making small content edits that do not affect application behavior

-Improving README or other markdown files

For these types of changes, contributors may submit a pull request without running the full local development environment or test suite. However, contributors should still review their changes carefully to ensure accuracy and consistency with existing content.

If you are unsure whether your contribution requires local testing, feel free to open an issue or ask for clarification in your pull request description. Maintainers are happy to help guide you.
### Running The Odin Project Locally

Follow our [instructions on running The Odin Project locally](https://github.com/TheOdinProject/theodinproject/wiki/Running-The-Odin-Project-Locally). These instructions include all installations you will need as well as optional instructions for setting up authentication.

### Adding Curriculum Content

When new content is ready to be or has already been merged in the TOP curriculum repo, the web app must be updated to render that new content. The following instructions cover how to add new curriculum content to the web app, but you can also refer to them when editing existing content:

- [Adding a lesson](https://github.com/TheOdinProject/theodinproject/wiki/Adding-a-Lesson)
- [Adding a section](https://github.com/TheOdinProject/theodinproject/wiki/Adding-a-Section)
- [Adding a course](https://github.com/TheOdinProject/theodinproject/wiki/Adding-a-Course)
- [Adding a path](https://github.com/TheOdinProject/theodinproject/wiki/Adding-a-Path)

### Testing Changes Locally

Before submitting a pull request (PR) to our web app repo, you should run the following commands locally to test that any changes made don't cause any failures. This can be quicker than waiting for your PR to finish running its checks to see whether there are any failures, and it can also help prevent you from making an unnecessary amount of commits that all fail to resolve a test failure.

```bash
rubocop
yarn lint
rspec
```
