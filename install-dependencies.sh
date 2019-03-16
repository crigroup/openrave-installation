#!/bin/bash
#
# Authors:
#   Francisco Suarez <fsuarez6.github.io>
#
# Description:
#   OpenRAVE Installation Script: Dependencies

# Check ubuntu version
UBUNTU_VER=$(lsb_release -sr)
if [ ${UBUNTU_VER} != '14.04' ] && [ ${UBUNTU_VER} != '16.04' ] && [ ${UBUNTU_VER} != '18.04' ]; then
    echo "ERROR: Unsupported Ubuntu version: ${UBUNTU_VER}"
    echo "  Supported versions are: 14.04, 16.04 and 18.04"
    exit 1
fi

# Install dependencies
echo ""
echo "Installing OpenRAVE dependencies..."
echo ""
echo "Requires root privileges:"
# Update
if [ ${UBUNTU_VER} = '14.04' ]; then
  sudo apt-get update -q
  sudo apt-get install -q -y --no-install-recommends software-properties-common
  # ROS Indigo repository
  sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
  sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
  # Additional PPAs
  sudo apt-add-repository -y ppa:imnmfotmal/libccd
fi
sudo apt-get update -q
# Programs
sudo apt-get install -q -y --no-install-recommends build-essential cmake doxygen        \
g++ git ipython locate lsb-release octave python-dev python-h5py python-numpy           \
python-pip python-scipy python-setuptools python-wheel unzip wget
if [ ${UBUNTU_VER} = '14.04' ]; then
  sudo apt-get install -q -y --no-install-recommends qt4-dev-tools zlib-bin
elif [ ${UBUNTU_VER} = '16.04' ] || [ ${UBUNTU_VER} = '18.04' ]; then
  sudo apt-get install -y --no-install-recommends qt5-default minizip
fi
# Libraries
sudo apt-get install -q -y --no-install-recommends ann-tools libann-dev         \
libassimp-dev libavcodec-dev libavformat-dev libeigen3-dev libfaac-dev          \
libflann-dev libfreetype6-dev liblapack-dev libglew-dev libgsm1-dev             \
libmpfi-dev  libmpfr-dev liboctave-dev libode-dev libogg-dev libpcre3-dev       \
libqhull-dev libsoqt-dev-common libsoqt4-dev libswscale-dev libtinyxml-dev      \
libvorbis-dev libx264-dev libxml2-dev libxvidcore-dev
if [ ${UBUNTU_VER} = '14.04' ]; then
  sudo apt-get install -q -y --no-install-recommends collada-dom-dev libccd    \
  libpcrecpp0 liblog4cxx10-dev libqt4-dev
elif [ ${UBUNTU_VER} = '16.04' ] || [ ${UBUNTU_VER} = '18.04' ]; then
  sudo apt-get install -q -y --no-install-recommends libccd-dev                \
  libcollada-dom2.4-dp-dev liblog4cxx-dev libminizip-dev octomap-tools
fi

# updatedb for debugging purposes
sudo updatedb
