#!/bin/bash

# if error exit
set -e

mkdir -p ov_ws/src && cd ov_ws/src
git clone https://github.com/rpng/open_vins/
cd ..
catkin build
