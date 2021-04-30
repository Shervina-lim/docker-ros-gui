#!/bin/bash

if [ "$2" == "" ]
then
	echo
	echo "To create ros docker container with gui enabled"
   	echo 
	echo "Ensure that you are in the docker-ros-gui directory"
	echo "Usage: ./build.sh [ros_distro] [container_name] "
	echo
	echo "Note: sublime and ros are installed in the container"
	exit 1
fi

# load params
ros_distro="$1"
container_name="$2"
image_name="ros-gui-$1"
home=$HOME

echo "     Creating container with following details:"
echo "     ros_distro: $1"
echo "     container_name: $2" 
echo "     image name: ${image_name}"

# prepare scripts and folders
mkdir -p ${home}/docker-ros-gui/docker_entry/${container_name}

cp ${home}/docker-ros-gui/docker/bashrc ${home}/docker-ros-gui/docker/cp-bashrc

FILE1 = ${home}/docker-ros-gui/docker_entry/run.sh
FILE2 = ${home}/docker-ros-gui/docker_entry/delete.sh
if test -f "$FILE1" && test -f "$FILE2"; then
    echo "run.sh and delete.sh exists, skipping copy ..."
else
	echo "copying run.sh and delete.sh ..."
	cp ${home}/docker-ros-gui/docker/run.sh ${home}/docker-ros-gui/docker_entry/run.sh
	cp ${home}/docker-ros-gui/docker/delete.sh ${home}/docker-ros-gui/docker_entry/delete.sh
	chmod +x ${home}/docker-ros-gui/docker_entry/*.sh 
fi
# if test -f !"$FILE1" && test -f !"$FILE2"; then
# 	cp ${home}/docker-ros-gui/docker/run.sh ${home}/docker-ros-gui/docker_entry/run.sh
# 	cp ${home}/docker-ros-gui/docker/delete.sh ${home}/docker-ros-gui/docker_entry/delete.sh
# 	chmod +x ${home}/docker-ros-gui/docker_entry/*.sh 
# fi

echo "source /opt/ros/${ros_distro}/setup.bash" >> ${home}/docker-ros-gui/docker/cp-bashrc
# build custom docker image
docker build \
	-- quiet \
	--build-arg ros_distro="${ros_distro}" \
	-t ${image_name} \
	-f docker/Dockerfile .
# create container with custom image
docker create -it \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --name ${container_name} \
    ${image_name}

docker ps -aqf "name=${container_name}" > "${home}/docker-ros-gui/docker_entry/${container_name}/containerId.txt"
rm -rf ${home}/docker-ros-gui/docker/cp-bashrc

echo ""
echo "Container is create!"
echo ""
echo "Command to start container: ./docker-ros-gui/docker_entry/run.sh ${container_name}"
