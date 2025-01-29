# The Odin Project Web App Contributing Guide

Thank you for expressing interest in contributing to The Odin Project (TOP) web app! Before continuing through this guide, be sure you've read our [general contributing guide](https://github.com/TheOdinProject/.github/blob/main/CONTRIBUTING.md), as it contains information that is important for all of our repos.

This contributing guide assumes you have followed the instructions in our general contributing guide to fork and clone our web app repo.

## Table of Contents

- [How to Contribute](#how-to-contribute)
  - [Running The Odin Project Locally](#running-the-odin-project-locally)
  - [Adding Curriculum Content](#adding-curriculum-content)
  - [Testing Changes Locally](#testing-changes-locally)

## How to Contribute

Due to the complexity of our web app repo compared to some of our other repos, contributing requires you to be able to run our web app locally and to run tests to ensure any changes being made look and work as expected.

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
