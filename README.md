# Breaking Bad API

[![OS Version: iOS 13.0](https://img.shields.io/badge/iOS-13.0-green.svg)](https://www.apple.com/es/ios/ios-13/)
[![Build Status](https://travis-ci.com/davilinho/breakingbadapi.svg?branch=master)](https://travis-ci.com/davilinho/breakingbadapi)
[![Coverage Status](https://coveralls.io/repos/github/davilinho/breakingbadapi/badge.svg?branch=master)](https://coveralls.io/github/davilinho/breakingbadapi?branch=master)

In this manuscript we explain and discuss the changes that have been implemented, along with some additional tools that have been added to the project or the repository.

## Table of contents

- [Breaking Bad API](#breakingbadaPI)
  * [Table of contents](#table-of-contents)
  * [Code refactor](#code-refactor)
    + [Code styling](#code-styling)
    + [Architecture and design pattern](#architecture-and-design-pattern)
      - [Service and repository layers](#service-and-repository-layers)
      - [Model-View-ViewModel architecture](#model-view-viewmodel-architecture)
      - [A comment on reactive programming](#a-comment-on-reactive-programming)
    + [Storyboards and XIB files](#storyboards-and-xib-files)
    + [Dependency injection](#dependency-injection)
  * [Feature implementation](#feature-implementation)
    + [iOS 13 and dark mode](#ios-13-and-dark-mode)
  * [Tests](#tests)
    + [Unit tests](#unit-tests)
    + [Snapshot tests](#snapshot-tests)
    + [UI tests](#ui-tests)
      - [MockServer](#mockserver)
  * [Third-party frameworks](#third-party-frameworks)
    + [AlamofireImage](#alamofireimage)
    + [DataSourceController](#datasourcecontroller)
    + [SnapshotTesting](#snapshottesting)
    + [Swifter](#swifter)
  * [Tools](#tools)
    + [Continuous Integration server](#continuous-integration-server)
    + [Code coverage reports](#code-coverage-reports)
  * [Branching strategy](#branching-strategy)

### Continuous Integration server

Since this repository is *public* (since it's forked from a *public* repository), we created a Travis CI instance attached to it to run tests and perform additional tasks automatically when several conditions met. In combination with our [Branching strategy](#branching-strategy) and some protection rules on `master` and `develop`, we ensure that no code was ever merged to these branches without passing the proper tests.

The current jobs and triggers are the following:
- **Compile**: Just compiles the app. This job is executed when a pull request to `master` or `develop` is opened, to prevent merging any change that breaks the app build. If this job fails, no further jobs are executed.
- **Run unit tests**: Runs the unit tests suite. This job is executed when a pull request to `master` or `develop` is opened.
- **Run UI tests**: Runs the UI tests suite. This job is executed when a pull request to `master` or `develop` is opened.
- **Gather code coverage data**: Runs the complete tests suites. If all test succeed, the coverage data is uploaded to Coveralls using Slather (see [Code coverage reports](#code-coverage-reports) below). This job is executed when a commit is pushed to either `master` or `develop`. Note that since both branches are protected and only pushes by means of pull requests are allowed, tests should always succeed (since they must succeed to enable merging).

You may take a look at all the jobs execute, and to the Travis CI instance, by following this link:

[https://travis-ci.com/davilinho/breakingbadapi](https://travis-ci.com/davilinho/breakingbadapi)

### Code coverage reports

Since this repository is *public* (since it's forked from a *public* repository), we created a Coveralls instance attached to it to gather code coverage data and display it as a report. This code coverage data is generated automatically by Xcode command line tools when running tests if properly set, and gathered and uploaded to Coveralls using [Slather](https://github.com/SlatherOrg/slather).

You may take a look at the code coverage reports for `master` in Coveralls by following this link:

[https://coveralls.io/github/davilinho/breakingbadapi](https://coveralls.io/github/davilinho/breakingbadapi)
