# nla-arclight

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/nla/nla-arclight/verify.yml?branch=main&logo=github)
![GitHub release (latest SemVer including pre-releases)](https://img.shields.io/github/v/release/nla/nla-arclight?include_prereleases)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)

Custom implementation of [ArcLight](https://samvera.atlassian.net/wiki/spaces/samvera/pages/405211890/ArcLight) for The National Library of Australia.

## Table of Contents

* [Requirements](#requirements)
* [Configuration](#configuration)
    + [Environment Variables](#environment-variables)
        - [ArcLight database](#arclight-database)
        - [Solr](#solr)
        - [Temp and caching directories](#temp-and-caching-directories)
        - [External services](#external-services)
        - [Rails settings](#rails-settings)
* [Setup](#setup)
* [Running the app](#running-the-app)
* [Tests](#tests)
* [Continuous Integration](#continuous-integration)
    + [Releases](#releases)
* [Deployment](#deployment)
* [Linting, Static Analysis & Supply Chain Vulnerability Checking](#linting--static-analysis---supply-chain-vulnerability-checking)

## Requirements

* Ruby: 3.1.2
* Bundler: 2.3.26

* System dependencies
    - Solr: 8
    - MySQL: 8

* Gems:
    - [blacklight-solrcloud-repository](https://github.com/nla/blacklight-solrcloud-repository)

The [GoRails guide](https://gorails.com/setup) has great instructions for setting up Ruby, Rails and MySQL for your operating system.

## Contributing

✏️ This repository uses [conventional commits](https://www.conventionalcommits.org)
and commit messages are used to generate `CHANGELOG.md` and release body entries.

The most important prefixes you should have in mind are:

* `fix:` which represents bug fixes, and correlates to a SemVer patch.
* `feat:` which represents a new feature, and correlates to a SemVer minor.
* `feat!:`, or `fix!:`, `refactor!:`, etc., which represent a breaking change (indicated by the !) and will result in a SemVer major.

Releases are automated via GitHub workflows. See more in the ["Releases"](#releases) section below.

## Configuration

All configurable values should be defined via environment variables. `dotenv` will automatically load values
from the `.env*` config in development and test environments.

Non-sensitive values for development and test environments should be defined in the `.env.development`/`.env.test` files.

Sensitive values can be defined in `.env.development.local` or `.env.test.local` files for local development
and *SHOULD NOT* be committed to source control. Git is configured to ignore these files.

⚠️ If `dotenv` fails to load the configuration values into the environment, you can manually export these
values in your terminal before running the application.

### Environment Variables

#### ArcLight database
    DATABASE_URL

#### Solr
    SOLR_URL - single node Solr
    
    ZK_HOST - Zookeeper connection string for the Solr Cloud cluster
    SOLR_COLLECTION - Solr Cloud collection for the catalogue index

#### Temp and caching directories
These variables are mainly used in the deployment environment.

    PIDFILE - relocates the server pid file outside of the application directory
    ARCLIGHT_TMP_PATH - relocates the caching directory outside of the application directory

#### External services
    GETALIBRARYCARD_BASE_URL - base URL for Get a Library Card
    GETALIBRARYCARD_AUTH_PATH - path to the authentication endpoint of Get a Library Card
    GETALIBRARYCARD_PATRON_DETAILS_PATH - path to the user details endpoint of Get a Library Card

    KEYCLOAK_CLIENT - name of the client
    KEYCLOAK_SECRET - secret defined in the client credentials
    KEYCLOAK_URL - base URL of the Keycloak server e.g. https://login-devel.nla.gov.au
    KEYCLOAK_REALM - name of the Keycloak realm

#### Rails settings
These variables are mainly used in the `staging` or `production` environment.

    SECRET_KEY_BASE - used by Devise for encrypting session values
    RAILS_LOG_TO_STDOUT - makes Rails logs print to the console
    RAILS_SERVE_STATIC_FILES - tells Rails to serve static assets from the /public directory

## Setup

1. Clone the app from GitHub.
2. Make sure you have MySQL running locally and configured in the `.env.development.local` config file.
3. Make sure you have Solr running locally and configured in the `.env.development.local` config file.<br />⚠️  If you are not planning on modifying the index, you can point this at the  devel or test environment Solr cluster.
4. `bin/setup` installs gems and performs database migrations for the `development` environment.<br /> ⚠️ Gems are installed in `vendor/bundle`.

## Running the app

* `bin/run` runs the Rails server at http://localhost:3000.
    * By default Rails will load the `development` environment.
    * The runtime environment can be changed by defining `RAILS_ENV` before executing a command/script. e.g.

```bash
RAILS_ENV=test bin/ci
```

## Tests

* `bin/ci` contains all the tests and security vulnerability checks for the app.
* `tmp/test.log` will use the production logging format *NOT* the development one.
* The following test frameworks are used:
    * [RSpec](https://rspec.info/) - for BDD testing
    * [Cucumber](https://github.com/cucumber/cucumber-rails) - for acceptance testing
    * [Capybara](http://teamcapybara.github.io/capybara/) - simulates web application interaction
    * [Webmock](https://github.com/bblimke/webmock) - HTTP request mocking and stubbing

## Continuous Integration

* CI is performed by [GitHub Actions](https://docs.github.com/en/actions).
* Workflows are defined in `.github/workflows`.

### Releases

Releases are automated via the `release.yml` GitHub workflow. This uses Google's
[release-please action](https://github.com/google-github-actions/release-please-action) to create pull
requests when changes are pushed to main. It will bump the version automatically and create a release
when the pull request is merged. Read more about how
[release-please](https://github.com/googleapis/release-please) works.

🚨 `CHANGELOG.md` is automatically created/updated for each release based on the commit messages.

## Deployment

* All runtime configuration should be supplied as environment variables.
* Rails logging uses [lograge](https://github.com/roidrage/lograge). `bin/setup help` can tell you how to see this locally.
* The temporary file directory configured by the `ARCLIGHT_TMP_PATH` must be writable by the user that runs the application.
* Gems declared in the Gemfile are installed in the `vendor/bundle` directory.
* Rails assets must be precompiled before deployment and `RAILS_SERVE_STATIC_FILES` set to `true` in order for files in the `public` directory to be accessible.
* `RAILS_LOG_TO_STDOUT` must be set to `true` for logs to be sent to the console.

## Linting, Static Analysis & Supply Chain Vulnerability Checking

The following tools provide linting, security and vulnerability checking of the code.

* [rubocop](https://rubocop.org/) and [standardrb](https://github.com/testdouble/standard) ensure standardised code formatting and best practices.
* [brakeman](https://github.com/presidentbeef/brakeman) provides static analysis checking.
    * Reports are written to `tmp/brakeman.html`
* [bundler-audit](https://github.com/rubysec/bundler-audit) checks application dependencies for security vulnerabilities.
