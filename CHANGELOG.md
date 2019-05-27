# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html) (Or at least attempts to)

## [Unreleased]

## [0.1.16] - 05-27-2019

### Fixed
- Lots of exception related stuff so if youre sudo apt-install fails, the whole
  process isnt waste

## [0.1.13] - 05-26-2019

### Fixed
- Finally seem to have fixed issues related to npm race condition and dependency issues
- Fixed silversearch-ag to silversearcher-ag

## [0.1.12] - 05-26-2019

### Fixed
- Renamed ADDED_REPOS to LIBS and never fixed it

## [0.1.11] - 05-26-2019

### Fixed
- Fixed an issue with node-gyp installs failing on Lubuntu 18.10
- Fixed an issue where npm install was not being install globally

### Added
- Added libssl1.0-dev to packages due to it being a node-gyp dependency
- Added silversearcher-ag as well

### Additional Notes
- Really feeling the pain of manual testing of packages on different computers / OS'es
- I understand why Docker is so great now

## [0.1.10] - 05-26-2019

### Fixed
- Fixed an issue with printing errors
- Fixed an issue with printing github public keys to command line

## [0.1.9] - 05-26-2019

### Added
- This changelog
- Language server support
- additional commands
  * update_all, login, and version
- additional documentation

### Changed
- Changed the way ssh keys are handled
- Changed some minor syntax
- Updated the README to include SOPS / GPG prereqs
