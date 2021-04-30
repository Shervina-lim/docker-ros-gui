#!/bin/bash
# load params
container_name="$1"
home=$HOME

if [ "$1" == "" ]
then
	echo
	echo "Script to run container ..."
	echo "Usage: ./run.sh [container_name] "
	echo
	exit 1
fi

container_id=`cat "${home}/docker-ros-gui/docker_entry/${container_name}/containerId.txt"`
echo "${container_id}"
# allow gui
xhost +local:`docker inspect --format='{{ .Config.Hostname }}' $container_id`
# check if container has start
if [ "`docker ps -qf "id=${container_id}"`" == "" ]
then
	echo "Starting previously stopped container..."
	docker start "${container_id}"
fi

echo "Executing into container ..."
docker exec -ti ${container_id} /bin/bash