#!/bin/bash

mode=$1
nvidia=$2
if [ "$1" == "" ];
then
    echo
    echo "To build custom docker image for ros melodic"
    echo 
    echo "Usage: ./build.sh [mode]"
    echo
    echo "Mode: nvidia-root, nvidia-user, cpu-root, cpu-user"
    echo
    exit 1
else
	echo 
	echo "Building ${mode} image ..."
	echo
fi

if [ "$mode" == "nvidia-root" ]; then
	echo "building nvidia root"
	docker build -t sl/u18-melodic:nvidia-root -f docker/nvidia/Dockerfile-nvidia-root .

elif [ "$mode" == "cpu-root" ]; then
	echo "building cpu root"
	docker build -t sl/u18-melodic:cpu-root -f docker/cpu/Dockerfile-root .

elif [ "$mode" == "nvidia-user" ]; then
	echo "building nvidia user"
	docker build -t sl/u18-melodic:nvidia-user -f docker/nvidia/Dockerfile-nvidia-user .

elif [ "$mode" == "cpu-user" ]; then
	echo "building cpu user"
	docker build -t sl/u18-melodic:cpu-user -f docker/cpu/Dockerfile-user .
fi

