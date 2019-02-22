[![Build Status](https://travis-ci.org/t0rrant/cookbook-shifter.svg?branch=master)](https://travis-ci.org/t0rrant/cookbook-shifter)
[![Cookbook Version](https://img.shields.io/cookbook/v/shifter.svg)](https://supermarket.chef.io/cookbooks/shifter)

# shifter

Chef cookbook that installs Shifter - Linux Containers for HPC

## Requirements

Requires the following cookbooks:

 - 'tar', '~> 2'


## Platforms

The following platforms are supported:

- Ubuntu (>= 14.04)
- Debian (>= 8.0)
- CentOS (>= 6)

## Chef

- Chef 14.0+

## TODO

- Add support for other options for udiRoot.conf config file
- Add support for static sshd build

## Usage

To have the shifter resources available to your cookbook just include ```cookbook 'shifter', '~> 0'``` in your Berksfile.

## Resources

### shifter_compile

Compiles shifter components from [NERSC's git repo](https://github.com/NERSC/shifter/), by default. 

### shifter_install

Compiles shifter components, if they haven't been compiled already, and creates appropriate symlinks and config files for Shifter Runtime.

### shifter_install_imagegw

Compiles shifter components, if they haven't been compiled already, and creates appropriate symlinks and config files for Shifter Image Gateway.


| Attribute Name                | Description                                   |
|---|---|
| `['shifter']['system']`       | Name of your system, e.g., edison or cori. This name must match a configured system in the imagegw. This is primarily used by shifterimg to self-identify which system it is representing. |
| `['shifter']['imagegw_fqdn']` | Space seperated URLs for your imagegw. Used by shifterimg and Slurm batch integration to communicate with the imagegw. |


## Authors

* Manuel Torrinha   <manuel.torrinha@tecnico.ulisboa.pt>
