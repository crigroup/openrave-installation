#!/bin/bash
#
# Authors:
#   Francisco Suarez-Ruiz <fsuarez6.github.io>
#
# Description:
#   OpenRAVE Installation Script: Dependencies

# Install dependencies
echo ""
echo "Installing OpenRAVE dependencies..."
echo ""
echo "Requires root privileges:"
# Update
if [ $(lsb_release -sr) = '14.04' ]; then
  # ROS Indigo repository
  sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
  sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
  # Additional PPAs
  sudo apt-add-repository -y ppa:imnmfotmal/libccd
fi
sudo apt-get update
# Programs
sudo apt-get install -y --no-install-recommends build-essential cmake doxygen \
g++ git ipython octave python-dev python-h5py python-numpy python-pip         \
python-scipy
if [ $(lsb_release -sr) = '14.04' ]; then
  sudo apt-get install -y --no-install-recommends qt4-dev-tools zlib-bin
elif [ $(lsb_release -sr) = '16.04' ]; then
  sudo apt-get install -y --no-install-recommends qt5-default minizip
fi
# Libraries
sudo apt-get install -y --no-install-recommends ann-tools libann-dev          \
libassimp-dev libavcodec-dev libavformat-dev libboost-python-dev              \
libboost-all-dev libeigen3-dev libfaac-dev libflann-dev libfreetype6-dev      \
liblapack-dev libglew-dev libgsm1-dev libmpfi-dev  libmpfr-dev liboctave-dev  \
libode-dev libogg-dev libpcre3-dev libqhull-dev  libsoqt-dev-common           \
libsoqt4-dev libswscale-dev libtinyxml-dev libvorbis-dev  libx264-dev         \
libxml2-dev libxvidcore-dev
if [ $(lsb_release -sr) = '14.04' ]; then
  sudo apt-get install -y --no-install-recommends collada-dom-dev libccd      \
  libpcrecpp0 liblog4cxx10-dev libqt4-dev
elif [ $(lsb_release -sr) = '16.04' ]; then
  sudo apt-get install -y --no-install-recommends libccd-dev                  \
  libcollada-dom2.4-dp-dev liblog4cxx-dev libminizip-dev octomap-tools
fi
