#!/bin/bash

# if error exit
set -e

echo "Note: This installation will upgrade opencv to 4.2.0-dev, may cause others to not work. e.g. vins mono"
echo "Please install this in a separate container"

# dependencies for orbslam3
apt update && apt install -y build-essential cmake git pkg-config libgtk-3-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev gfortran openexr libatlas-base-dev python3-dev python3-numpy libtbb2 libtbb-dev libdc1394-22-dev

# install pangolin
git clone https://github.com/stevenlovegrove/Pangolin
cd pangolin
mkdir build && cd build
cmake ..
cmake --build

# install googlelog
git clone https://github.com/google/glog
cd glog
cmake -H. -Bbuild -G "Unix Makefiles"
cmake --build build
cmake --build build --target test
cd build
sudo make install

# install opencv
mkdir ~/opencv_base
cd ~/opencv_base
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
cd ~/opencv_base/opencv
mkdir build && cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_base/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON ..
make -j
sudo make install

# install orb slam 3
git clone https://github.com/shanpenghui/ORB_SLAM3_Fixed.git
cd shells
./build.sh
./build_ros.sh

# add to bashrc
export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:<PATH>/ORB_SLAM3/Examples/ROS >> ~/.bashrc
