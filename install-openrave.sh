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

# Install boost
if [ ${UBUNTU_VER} = '14.04' ] || [ ${UBUNTU_VER} = '16.04' ]; then
    sudo apt-get install -q -y --no-install-recommends libboost-all-dev        \
    libboost-python-dev
elif [ ${UBUNTU_VER} = '18.04' ]; then
    # Install boost 1.58 from source
    BOOST_SRC_DIR=~/git/boost_1_58_0
    mkdir -p ~/git; cd ~/git
    wget https://vorboss.dl.sourceforge.net/project/boost/boost/1.58.0/boost_1_58_0.tar.gz -O ${BOOST_SRC_DIR}.tar.gz
    tar -xzf ${BOOST_SRC_DIR}.tar.gz
    cd ${BOOST_SRC_DIR}
    ./bootstrap.sh --exec-prefix=/usr/local
    ./b2 -j $(nproc)
    sudo ./b2 -j $(nproc) install
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
wget -q https://github.com/rdiankov/openrave/archive/${RAVE_COMMIT}.zip -O openrave.zip
unzip -q openrave.zip -d ~/git
cd ~/git/openrave-${RAVE_COMMIT}
mkdir build; cd build
if [ ${UBUNTU_VER} = '14.04' ] || [ ${UBUNTU_VER} = '16.04' ]; then
  cmake -DODE_USE_MULTITHREAD=ON -DOSG_DIR=/usr/local/lib64/ -Wno-deprecated -Wno-dev ..
elif [ ${UBUNTU_VER} = '18.04' ]; then
  cmake -DODE_USE_MULTITHREAD=ON -DCMAKE_CXX_STANDARD=11 -Wno-deprecated -Wno-dev           \
        -DBoost_NO_SYSTEM_PATHS=TRUE -DBOOST_ROOT=/usr/local/ ..
fi
make -j $(nproc)
sudo make install
