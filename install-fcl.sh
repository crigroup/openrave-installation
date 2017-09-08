#!/bin/bash
#
# Authors:
#   Francisco Suarez-Ruiz <fsuarez6.github.io>
#
# Description:
#   OpenRAVE Installation Script: FCL

# FCL - The Flexible Collision Library
echo ""
echo "Installing FCL 0.5.0 from source..."
echo ""
cd ~/git
git clone https://github.com/flexible-collision-library/fcl
cd fcl; git reset --hard 0.5.0
mkdir build; cd build
cmake ..
make -j `nproc`
sudo make install

# Sympy version 0.7.1
echo ""
echo "Downgrading sympy to version 0.7.1..."
echo ""
pip install --upgrade --user sympy==0.7.1

# OpenRAVE
COMMIT=9350ebc
echo ""
echo "Installing OpenRAVE 0.9 from source (Commit $COMMIT)..."
echo ""
cd ~/git
git clone https://github.com/rdiankov/openrave.git
cd openrave; git reset --hard $COMMIT
mkdir build; cd build
cmake -DODE_USE_MULTITHREAD=ON -DOSG_DIR=/usr/local/lib64/ ..
make -j `nproc`
sudo make install
