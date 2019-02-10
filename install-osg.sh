#!/bin/bash
#
# Authors:
#   Francisco Suarez-Ruiz <fsuarez6.github.io>
#
# Description:
#   OpenRAVE Installation Script: OpenSceneGraph

# OpenSceneGraph
OSG_COMMIT=1f89e6eb1087add6cd9c743ab07a5bce53b2f480
echo ""
echo "Installing OpenSceneGraph 3.4 from source (Commit ${OSG_COMMIT})..."
echo ""

mkdir -p ~/git; cd ~/git
git clone https://github.com/openscenegraph/OpenSceneGraph.git
cd OpenSceneGraph; git reset --hard ${OSG_COMMIT}
mkdir build; cd build
if [ $(lsb_release -sr) = '14.04' ]; then
  cmake ..
elif [ $(lsb_release -sr) = '16.04' ]; then
  cmake .. -DDESIRED_QT_VERSION=4
elif [ $(lsb_release -sr) = '18.04' ]; then
  cmake .. -DDESIRED_QT_VERSION=4
fi
make -j `nproc`
sudo make install
