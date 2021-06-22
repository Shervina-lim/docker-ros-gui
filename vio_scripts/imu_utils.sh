#!/bin/bash

# if error exit
set -e

# install dependency
apt-get install -y libdw-dev

# install ceres solver 1.14.0, for docker melodic
# apt -y install cmake libgoogle-glog-dev libgflags-dev libatlas-base-dev libeigen3-dev
# wget ceres-solver.org/ceres-solver-1.14.0.tar.gz
# tar xvf ceres-solver-1.14.0.tar.gz
# cd ceres-solver-1.14.0
# mkdir build && cd build
# cmake ../
# make -j4
# make test
# sudo make install

# install code utils
mkdir -p ~/imu_utils_ws/src
cd ~/imu_utils_ws/src
git clone https://github.com/Shervina-lim/code_utils.git
cd ~/imu_utils_ws
catkin_make

# install imu_utils
cd ~/imu_utils_ws/src
git clone https://github.com/gaowenliang/imu_utils.git
cd ~/imu_utils_ws
catkin_make
