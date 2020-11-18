#!/bin/bash
#
# Authors:
#   Francisco Suarez <fsuarez6.github.io>
#
# Description:
#   OpenRAVE Installation Script: Dependencies

# Check ubuntu version
UBUNTU_VER=$(lsb_release -sr)
if [ ${UBUNTU_VER} != '14.04' ] && [ ${UBUNTU_VER} != '16.04' ] && [ ${UBUNTU_VER} != '18.04' ] \
  && [ ${UBUNTU_VER} != '20.04' ]; then
    echo "ERROR: Unsupported Ubuntu version: ${UBUNTU_VER}"
    echo "  Supported versions are: 14.04, 16.04, 18.04, and 20.04"
    exit 1
fi

# Install dependencies
echo ""
echo "Installing OpenRAVE dependencies..."
echo ""
echo "Requires root privileges:"

# Update
if [ ${UBUNTU_VER} = '14.04' ]; then
  # ROS Indigo repository
  sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
  sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
  # Additional PPAs
  sudo apt-add-repository -y ppa:imnmfotmal/libccd
fi
sudo apt-get update

# Programs
sudo apt-get install -y --no-install-recommends build-essential cmake doxygen \
  g++ git octave python-dev python-setuptools wget mlocate
if [ ${UBUNTU_VER} = '14.04' ] || [ ${UBUNTU_VER} = '16.04' ] || [ ${UBUNTU_VER} = '18.04' ]; then
  sudo apt-get install -y --no-install-recommends ipython python-h5py python-numpy \
    python-pip python-wheel python-scipy
elif [ ${UBUNTU_VER} = '20.04' ]; then
  sudo apt-get install -y --no-install-recommends python2 curl
  curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
  sudo python2 get-pip.py
  pip install ipython h5py numpy scipy wheel pyopengl
fi
if [ ${UBUNTU_VER} = '14.04' ]; then
  sudo apt-get install -y --no-install-recommends qt4-dev-tools zlib-bin
elif [ ${UBUNTU_VER} = '16.04' ] || [ ${UBUNTU_VER} = '18.04' ] || [ ${UBUNTU_VER} = '20.04' ]; then
  sudo apt-get install -y --no-install-recommends qt5-default minizip
fi

# Libraries
sudo apt-get install -y --no-install-recommends ann-tools libann-dev            \
libassimp-dev libavcodec-dev libavformat-dev libeigen3-dev libfaac-dev          \
libflann-dev libfreetype6-dev liblapack-dev libglew-dev libgsm1-dev             \
libmpfi-dev  libmpfr-dev liboctave-dev libode-dev libogg-dev libpcre3-dev       \
libqhull-dev libswscale-dev libtinyxml-dev libvorbis-dev libx264-dev            \
libxml2-dev libxvidcore-dev libbz2-dev
if [ ${UBUNTU_VER} = '14.04' ] || [ ${UBUNTU_VER} = '16.04' ] || [ ${UBUNTU_VER} = '18.04' ]; then
  sudo apt-get install -y --no-install-recommends libsoqt-dev-common libsoqt4-dev
elif [ ${UBUNTU_VER} = '20.04' ]; then
  sudo apt-get install -y --no-install-recommends libsoqt520-dev
fi
if [ ${UBUNTU_VER} = '14.04' ]; then
  sudo apt-get install -y --no-install-recommends collada-dom-dev libccd      \
  libpcrecpp0 liblog4cxx10-dev libqt4-dev
elif [ ${UBUNTU_VER} = '16.04' ] || [ ${UBUNTU_VER} = '18.04' ] || [ ${UBUNTU_VER} = '20.04' ]; then
  sudo apt-get install -y --no-install-recommends libccd-dev                  \
  libcollada-dom2.4-dp-dev liblog4cxx-dev libminizip-dev octomap-tools
fi

# Install boost
sudo apt-get install -y --no-install-recommends libboost-all-dev libboost-python-dev

if [ ${UBUNTU_VER} = '18.04' ] || [ ${UBUNTU_VER} = '20.04' ]; then
  # Install opengl
  pip install pyopengl

  # Install RapidJSON
  mkdir -p ~/git 
  cd ~/git && git clone https://github.com/Tencent/rapidjson.git
  cd rapidjson && mkdir build && cd build
  cmake .. && make -j `nproc` && sudo make install

  # Install Pybind
  cd ~/git && git clone https://github.com/pybind/pybind11.git 
  cd pybind11
  # Set Git credentials to allow git cherry-pick
  git config --local user.name crigroup
  git config --local user.email crigroup@example.com
  echo "Random Git credentials set as: crigroup (username) and crigroup@example.com (email)"
  mkdir build && cd build 
  git remote add woody https://github.com/woodychow/pybind11.git \
    && git remote add cielavenir https://github.com/cielavenir/pybind11.git \
    && git fetch woody && git fetch cielavenir && git checkout v2.2.4 \
    && git cherry-pick 94824d68a037d99253b92a5b260bb04907c42355 \
    && git cherry-pick 98c9f77e5481af4cbc7eb092e1866151461e3508 \
    && git cherry-pick dae2d434bd806eac67e38f3c49cfc91f46e4fd88 \
    && git cherry-pick 2e08ce9ba75f5a2d87a6f12e6ab657ac78444e8e \
    && cmake .. -DPYBIND11_TEST=OFF -DPythonLibsNew_FIND_VERSION=2 \
    && sudo make install
fi

# updatedb for debugging purposes
sudo updatedb
