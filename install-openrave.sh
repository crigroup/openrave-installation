#!/bin/bash
#
# Authors:
#   Francisco Suarez <fsuarez6.github.io>
#
# Description:
#   OpenRAVE Installation Script

# Check ubuntu version
UBUNTU_VER=$(lsb_release -sr)
if [ ${UBUNTU_VER} != '14.04' ] && [ ${UBUNTU_VER} != '16.04' ] && [ ${UBUNTU_VER} != '18.04' ]; then
    echo "ERROR: Unsupported Ubuntu version: ${UBUNTU_VER}"
    echo "  Supported versions are: 14.04, 16.04 and 18.04"
    exit 1
fi

# Sympy version 0.7.1
echo ""
echo "Downgrading sympy to version 0.7.1..."
echo ""
pip install --upgrade --user sympy==0.7.1

# OpenRAVE
RAVE_COMMIT=7c5f5e27eec2b2ef10aa63fbc519a998c276f908
echo ""
echo "Installing OpenRAVE 0.9 from source (Commit ${RAVE_COMMIT})..."
echo ""
mkdir -p ~/git; cd ~/git
git clone https://github.com/rdiankov/openrave.git
cd openrave; git reset --hard ${RAVE_COMMIT}
mkdir build; cd build
if [ ${UBUNTU_VER} = '14.04' ] || [ ${UBUNTU_VER} = '16.04' ]; then
  cmake -DODE_USE_MULTITHREAD=ON -DOSG_DIR=/usr/local/lib64/ ..
elif [ ${UBUNTU_VER} = '18.04' ]; then
  cmake -DODE_USE_MULTITHREAD=ON -DCMAKE_CXX_STANDARD=11            \
        -DBoost_NO_SYSTEM_PATHS=TRUE -DBOOST_ROOT=/usr/local/ ..
fi
make -j `nproc`
sudo make install
