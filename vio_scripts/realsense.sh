!#bin/bash

set -e 

apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE 
add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo bionic main" -u
apt-get install -y librealsense2-dkms librealsense2-utils ros-melodic-realsense2-camera
source .bashrc
roscd realsense2_camera/launch
cp rs_t265.launch t265_imu.launch