# shifter CHANGELOG
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

This file is used to list changes made in each version of the shifter cookbook.


## 1.0.2

### Fixed

- Ubuntu 16.04 systemd issues

## 1.0.1

### Added

- munge.service systemd unit dependency
 
## 1.0.0

### Added

- `imagegw_log_dir` property to `install_imagegw` resource
- ensure service start for `munge` and `mongodb` services

### Changed

- creation of shifter_imagegw log directory to the recipe as mkdir command location differs from system to system 

### Fixed

- `imagemanager.json` typo
- Shifter Image Gateway systemd service unit
- symlinks for `shifter` and `shifterimg` binaries
- symlinks for the container mount directory 

## 0.2.7

### Fixed

- removal of the whole /tmp dir instead of just the extraction dir

## 0.2.6

### Removed

- support for non-systemd distros, temporary

## 0.2.5

### Changed

- kitchen test run_list to have all the recipes together

### Removed

- remaining support reference for CentOS

## 0.2.4

### Changed

- systemd service file location

### Removed

- support for CentOS, temporarily

## 0.2.3

### Fixed

- Ruby syntax error

## 0.2.2

### Changed

- `imagegw_fqdn` property value which is passed down to the `compile` resource   

## 0.2.1

### Fixed

- linting

## 0.2.0

### Added

- mandatory imagemanager.json config file for shifter_imagegw
- shifter_imagegw systemd service file
- helper variables
- shifter_imagegw dependencies installation

### Fixed

- udiRoot.conf location

## 0.1.1

### Added

- Guidelines for contributing to this cookbook

### Changed

- Version syntax so it complies with supermarket rules

## 0.1.0

Initial release.

### Added

- Resources to compile and install shifter, still without configuration files
- Helper file
