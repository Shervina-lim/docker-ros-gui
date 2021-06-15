#!/bin/bash

# if error exit
set -e

# install msckf
mkdir -p msckf_ws/src && cd msckf_ws/src
git clone https://github.com/uzh-rpg/fast.git
cd .. 
catkin_make --pkg fast
cd src
git clone https://github.com/daniilidis-group/msckf_mono.git
catkin_make
