#!/bin/bash
#
# Authors:
#   Francisco Suarez <fsuarez6.github.io>
#
# Description:
#   OpenRAVE Installation Script: FCL

# Check ubuntu version
UBUNTU_VER=$(lsb_release -sr)
if [ ${UBUNTU_VER} != '14.04' ] && [ ${UBUNTU_VER} != '16.04' ] && [ ${UBUNTU_VER} != '18.04' ] \
  && [ ${UBUNTU_VER} != '20.04' ]; then
    echo "ERROR: Unsupported Ubuntu version: ${UBUNTU_VER}"
    echo "  Supported versions are: 14.04, 16.04, 18.04, and 20.04"
    exit 1
fi

# FCL - The Flexible Collision Library
echo ""
echo "Installing FCL 0.5.0 from source..."
echo ""
mkdir -p ~/git; cd ~/git
git clone https://github.com/flexible-collision-library/fcl
cd fcl; git reset --hard 0.5.0
mkdir build; cd build
cmake .. -DFCL_BUILD_TESTS=OFF
make -j `nproc`
sudo make install
