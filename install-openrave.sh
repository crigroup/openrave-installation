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
COMMIT=7c5f5e2
echo ""
echo "Installing OpenRAVE 0.9 from source (Commit $COMMIT)..."
echo ""
mkdir -p ~/git; cd ~/git
git clone https://github.com/rdiankov/openrave.git
cd openrave; git reset --hard $COMMIT
mkdir build; cd build
cmake -DODE_USE_MULTITHREAD=ON -DOSG_DIR=/usr/local/lib64/  -DCMAKE_CXX_STANDARD=11 ..
make -j `nproc`
sudo make install
