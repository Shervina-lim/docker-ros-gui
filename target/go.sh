#!/bin/bash

current_dir=`pwd -P`
script_dir="$( cd "$(dirname "$0")" ; pwd -P )"
container_name=`cat "${script_dir}/docker_name"`

if [ "${container_name}" == "" ]
then
	echo "Error: No docker name found in '${script_dir}/docker_name'"
	exit 1
fi

    if [ "`docker ps -qf "name=${container_name}"`" == "" ]
    then
    	echo "Starting previously stopped container..."
    	docker start "${container_name}"
    fi

    docker exec -ti ${container_name} /rosbox_entrypoint.sh


