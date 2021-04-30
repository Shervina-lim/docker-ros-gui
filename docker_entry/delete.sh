#!/bin/bash
container_name="$1"
home=$HOME

container_id=`cat "${home}/docker-ros-gui/docker_entry/${container_name}/containerId.txt"`

if [ "$1" == "" ]
then
	echo
	echo "Script to delete container ..."
	echo "Usage: ./delete.sh [container_name]"
	echo
	exit 1
fi

if [ -d "${home}/docker-ros-gui/docker_entry/${container_name}" ] 
then
	if [ "`docker ps -qf "id=${container_id}"`" != "" ]
	then
		echo "Stopping container..."
		docker stop "${container_id}"
	fi

	docker rm ${container_id}

	echo ""	
	echo "Folder exists ... Deleting it now!"
	rm -r ${home}/docker-ros-gui/docker_entry/${container_name}
	echo ""
	echo "Container and relevant info has been successfully deleted!"
	
else
	echo "Container does not exist! Aborting this ..."
fi