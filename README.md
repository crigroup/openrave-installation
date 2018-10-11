# openrave-installation

Bash scripts to install OpenRAVE from source

## Travis - Continuous Integration

[![Build Status](https://travis-ci.org/crigroup/openrave-installation.svg?branch=master)](https://travis-ci.org/crigroup/openrave-installation)


## Installation
Run the scripts in the following order:
```bash
./install-dependencies.sh
./install-osg.sh
./install-fcl.sh
./install-openrave.sh
```

## Post-installation 
If you have a segfault, place this line in .bashrc or .zshrc and try
again.

```bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib64
```
