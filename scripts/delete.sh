#!/bin/bash
container_name="$1"
home=$HOME

if [ "$1" == "" ]
then
	echo
	echo "Script to delete container ..."
	echo "Usage: ./delete.sh [container_name]"
	echo
	exit 1
fi

if [ "`docker ps -qf "id=${container_name}"`" != "" ]
then
	echo "Stopping container..."
	docker stop "${container_name}"
fi

	docker rm ${container_name}

	echo ""
	echo "Container info has been successfully deleted!"
	echo ""	
	echo "Do you want to delete container data? Y/N"
	read var
	echo "u choose, $var"
	if [[ $var == "Y" || $var == "y" ]]; then
		sudo rm -rf ${home}/docker-ws/${container_name}
		echo "All data has been cleared!"
	else
		echo "Note that container data can be found in ${home}/docker-ws/${container_name}"
	fi