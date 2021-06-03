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
echo id
xhost -local:root
xhost +local:`docker inspect --format='{{ .Config.Hostname }}' $id`

# check if container has start
if [ "`docker ps -qf "id=${id}"`" == "" ]
then
	echo "Starting previously stopped container..."
	docker start "${id}"
fi

echo "Executing into container ..."
docker exec -ti ${id} bin/bash