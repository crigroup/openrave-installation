#!/bin/bash
#
# Authors:
#   Francisco Suarez <fsuarez6.github.io>
#
# Description:
#   OpenRAVE Installation Script: OpenSceneGraph

# Check ubuntu version
UBUNTU_VER=$(lsb_release -sr)
if [ ${UBUNTU_VER} != '14.04' ] && [ ${UBUNTU_VER} != '16.04' ] && [ ${UBUNTU_VER} != '18.04' ]; then
    echo "ERROR: Unsupported Ubuntu version: ${UBUNTU_VER}"
    echo "  Supported versions are: 14.04, 16.04 and 18.04"
    exit 1
fi

# OpenSceneGraph
OSG_COMMIT=1f89e6eb1087add6cd9c743ab07a5bce53b2f480
echo ""
echo "Installing OpenSceneGraph 3.4 from source (Commit ${OSG_COMMIT})..."
echo ""

mkdir -p ~/git; cd ~/git
wget -q https://github.com/openscenegraph/OpenSceneGraph/archive/${OSG_COMMIT}.zip -O OpenSceneGraph.zip
unzip -q OpenSceneGraph.zip -d ~/git
cd ~/git/OpenSceneGraph-${OSG_COMMIT}
mkdir build; cd build

BUILD_OSG_APPLICATIONS=ON
if [ ${CI} ]; then
    BUILD_OSG_APPLICATIONS=OFF
fi

if [ ${UBUNTU_VER} = '14.04' ]; then
  cmake -DBUILD_OSG_APPLICATIONS=${BUILD_OSG_APPLICATIONS} ..
elif [ ${UBUNTU_VER} = '16.04' ] || [ ${UBUNTU_VER} = '18.04' ]; then
  cmake -DBUILD_OSG_APPLICATIONS=${BUILD_OSG_APPLICATIONS} -DDESIRED_QT_VERSION=4 ..
fi
make -j $(nproc)
sudo make install
sudo make install_ld_conf
