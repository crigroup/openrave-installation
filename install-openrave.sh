#!/bin/bash
#
# Authors:
#   Francisco Suarez-Ruiz <fsuarez6.github.io>
#
# Description:
#   OpenRAVE Installation Script

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
if [ $(lsb_release -sr) = '14.04' ]; then
  cmake -DODE_USE_MULTITHREAD=ON -DOSG_DIR=/usr/local/lib64/ ..
elif [ $(lsb_release -sr) = '16.04' ]; then
  cmake -DODE_USE_MULTITHREAD=ON -DOSG_DIR=/usr/local/lib64/ ..
# to compile on ubuntu 18.04, C11 is needed.
elif [ $(lsb_release -sr) = '18.04' ]; then
  cmake -DODE_USE_MULTITHREAD=ON -DOSG_DIR=/usr/local/lib64/ -DCMAKE_CXX_STANDARD=11 ..
fi
make -j `nproc`
sudo make install
