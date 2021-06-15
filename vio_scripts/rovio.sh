#!/bin/bash

# if error exit
set -e

mkdir -p rovio_ws/src && cd rovio_ws/src
git clone https://github.com/ethz-asl/kindr.git
git clone https://github.com/ethz-asl/rovio.git 
cd rovio 
rm –rf lightweight_filtering 
git clone https://bitbucket.org/bloesch/lightweight_filtering.git
cd ../..
catkin build kindr
catkin build rovio --cmake-args -DCMAKE_BUILD_TYPE=Release
