#!/bin/bash

# if error exit
set -e

apt-get install libv4l-dev
mkdir -p ~/kalibr_ws/src && cd ~/kalibr_ws/src
git clone https://github.com/ethz-asl/kalibr.git
cd ~/kalibr_ws
catkin build

