# shifter CHANGELOG
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

This file is used to list changes made in each version of the shifter cookbook.

## 1.2.0

### Added

- new argument `siteenv_append` to allow for customized Environment Variables within the containers.

### Fixed

- wrong directory name

## 1.1.0

### Added

- shifterimg symlink to shifter installations as we want to able to issue image pulls from external nodes

### Changed

- binary links from install_imagegw to install, as the imagegw is but a service

## 1.0.11

### Fixed

- another typo

## 1.0.10

### Fixed

- shifter compile property 

## 1.0.9

### Fixed

- shifter compile property

## 1.0.8

### Added

- system_name property, which allows for compute nodes to pull and use images

## 1.0.7

### Fixed

- Chef logging

## 1.0.6

### Added

- slurm development files as dependency to compile with slurm support

## 1.0.5

### Fixed

- typo in condition

## 1.0.4

### Fixed

- `/etc/shifter/udiRoot.conf` udiImage

### Added

- `/opt/shifter/udiRoot/libexec/shifter/opt/udiImage` creation

## 1.0.3

### Fixed

- Ubuntu 16.04 systemd issues

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
