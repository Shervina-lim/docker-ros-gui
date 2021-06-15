!#bin/bash

# exit when error
set -e

# install libfovis 
git clone https://github.com/srv/libfovis.git
cd libfovis
mkdir build && cd build
cmake ..
make
sudo make install
sudo ldconfig

# install fovis
mkdir fovis_ws/src && cd fovis_ws/src
git clone https://github.com/srv/fovis.git
catkin_make
