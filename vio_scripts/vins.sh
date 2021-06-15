#!/bin/bash

# if error exit
set -e

# install ceres solver 1.14.0, for docker melodic
apt -y install cmake libgoogle-glog-dev libgflags-dev libatlas-base-dev libeigen3-dev
wget ceres-solver.org/ceres-solver-1.14.0.tar.gz
tar xvf ceres-solver-1.14.0.tar.gz
cd ceres-solver-1.14.0
mkdir build && cd build
cmake ../
make -j
make test
sudo make install

# install vins mono
mkdir -p vm_ws/src && cd vm_ws/src
git clone https://github.com/HKUST-Aerial-Robotics/VINS-Mono.git
cd ..	
catkin_make

# install vins fusion
mkdir -p vf_ws/src && cd vf_ws/src
git clone https://github.com/HKUST-Aerial-Robotics/VINS-Fusion.git
cd ..
catkin_make