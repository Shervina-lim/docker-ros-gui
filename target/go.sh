#!/bin/bash

current_dir=`pwd -P`
script_dir="$( cd "$(dirname "$0")" ; pwd -P )"
container_name=`cat "${script_dir}/docker_name"`

#sudo=y

# If user is part of docker group, sudo isn't necessary
#if groups $USER | grep &>/dev/null '\bdocker\b'; then
#    sudo = n
#fi

if [ "${container_name}" == "" ]
then
	echo "Error: No docker name found in '${script_dir}/docker_name'"
	exit 1
fi

# Shouldn't need to use sudo since we add user in docker.
# Check if the container is running

#if [ "$sudo" = "y" ]; then

#    if [ "`sudo docker ps -qf "name=${container_name}"`" == "" ]
#    then
#    	echo "Starting previously stopped container..."
#    	sudo docker start "${container_name}"
#    fi

    # Joining the container
#    sudo docker exec -ti ${container_name} /rosbox_entrypoint.sh
#else
    if [ "`docker ps -qf "name=${container_name}"`" == "" ]
    then
    	echo "Starting previously stopped container..."
    	docker start "${container_name}"
    fi

    docker exec -ti ${container_name} /rosbox_entrypoint.sh
fi

