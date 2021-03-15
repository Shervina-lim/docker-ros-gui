#!/bin/bash

ros_distro="$1"
container_name="$2"

image_name="ros-gui-$1"
dir=$(pwd)
echo "${dir}"
echo "ros_distro: $1"
echo "container_name: $2" 
echo "image name: ${image_name}"

# Modify bashrc file
cp ${dir}/docker/bashrc ${dir}/docker/cp-bashrc
echo "source /opt/ros/${ros_distro}/setup.bash" >> ${dir}/docker/cp-bashrc

docker build \
	-- quiet \
	--build-arg ros_distro="${ros_distro}" \
	-t ${image_name} \
	-f docker/Dockerfile .

docker create -it \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --name ${container_name} \
    ${image_name}

containerId=$(docker ps -aqf "name=${container_name}")
echo "Container Id: ${containerId}"

rm -rf /docker/cp-bashrc
# allow gui
xhost +local:`docker inspect --format='{{ .Config.Hostname }}' $containerId`
docker start ${containerId}
docker exec -it ${containerId} bash
