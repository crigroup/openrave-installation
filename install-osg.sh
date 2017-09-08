#!/bin/bash
#
# Authors:
#   Francisco Suarez-Ruiz <fsuarez6.github.io>
#
# Description:
#   OpenRAVE Installation Script: OpenSceneGraph

# OpenSceneGraph
echo ""
echo "Installing OpenSceneGraph 3.4 from source..."
echo ""
mkdir -p ~/git
cd ~/git
git clone https://github.com/openscenegraph/OpenSceneGraph.git
cd OpenSceneGraph; git reset --hard OpenSceneGraph-3.4
mkdir build; cd build
if [ $(lsb_release -sr) = '14.04' ]; then
  cmake ..
elif [ $(lsb_release -sr) = '16.04' ]; then
  cmake .. -DDESIRED_QT_VERSION=4
fi
make -j `nproc`
sudo make install
