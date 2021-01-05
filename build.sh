#!/bin/bash

set -e

current_dir=`pwd -P`
script_dir="$( cd "$(dirname "$0")" ; pwd -P )"

sudo=y

# If user is part of docker group, sudo isn't necessary
if groups $USER | grep &>/dev/null '\bdocker\b'; then
    sudo=n
fi

if [ "$2" == "" ]
then
	echo
	echo "Builds a docker image to run ROS and deploys a basic setup to work with it"
	echo
	echo "Usage: `basename $0` [ros_distro] [container_name/target]"
	echo "    ros_distro        The ROS distribution to work with (lunar, kinetic, etc.)"
	echo "    target            The target directory to deploy the basic setup"
	echo
	exit 1
fi

ros_distro="$1"
container_name="$2"
target="$2"
image_tag="ros-gui-${ros_distro}"
uid=`id -u`
gid=`id -g`
user_name="$2-dev"

# Make sure the target exists
if [ ! -d "${target}" ]
then
	mkdir -p "${target}"
fi
target=$( cd "${target}" ; pwd -P )


echo "Prepare the target environment..."
# Copy target files
/bin/cp -Ri "${script_dir}/target/"* "${target}/"
if [ ! -d "${target}/src" ]
then
	mkdir "${target}/src"
fi

# Build the docker image
echo "Build the docker image... (This can take some time)"
cd "${script_dir}/docker"
chmod +x rosbox_entrypoint.sh

    docker build \
        --quiet \
	    --build-arg ros_distro="${ros_distro}" \
        --build-arg uid="${uid}" \
        --build-arg gid="${gid}" \
    	-t ${image_tag} \
    	.

echo "create a new container from this image..."
cd "${target}"

# for gui
XSOCK=/tmp/.X11-unix
# for mounting volumes
#XAUTH=/tmp/.docker.xauth
#touch $XAUTH
#xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

# Save container name first
echo ${container_name} >> "${target}/docker_name"
chmod 444 "${target}/docker_name"

echo "container name is saved!"

docker run -it \
    	--user=$(id -u $USER):$(id -g $USER) \
	--env="DISPLAY" \
    	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
        -v "$(pwd)/${target}/src:/home/${user_name}/catkin_ws/src" \
	--name ${container_name} \
    	${image_tag} 
		


