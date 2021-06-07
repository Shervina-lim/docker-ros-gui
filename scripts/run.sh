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
# Allow X server host
export id=$(docker ps -aqf "name=${container_name}")
xhost -local:root
xhost +local:`docker inspect --format='{{ .Config.Hostname }}' $id`

# check if container started
if [ "`docker ps -qf "id=${id}"`" == "" ]
then
	echo "Starting previously stopped container..."
	docker start "${id}"
fi

# running container
echo "Executing into container ..."
docker exec -ti ${id} bin/bash

echo
echo
echo "	Giving permissions to read and write in docker-ws/${container_name}"
sudo chown -R $USER:$USER ~/docker-ws/${container_name}
echo "	Permission given!"
echo