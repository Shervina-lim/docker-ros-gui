#!/bin/bash

# if error exit
set -e

apt install -y libglew-dev
mkdir -p basalt_ws/src && cd basalt_ws/src
git clone --recursive https://github.com/berndpfrommer/basalt_ros.git
cd ..
catkin config -DCMAKE_BUILD_TYPE=Release
catkin build

