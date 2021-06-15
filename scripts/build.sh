#!/bin/bash

mode=$1
nvidia=$2
if [ "$1" == "" ];
then
    echo
    echo "To build custom docker image for ros melodic"
    echo 
    echo "Usage: ./build.sh [mode] [nvidia]"
    echo
    echo "mode: root, user"
    echo "nvidia: yes, no"
    echo
    exit 1
else
	echo 
	echo "Building ${mode} image ..."
	echo
fi

if [ "$mode" == "nvidia-root" ]; then
	if [ "$nvidia" == "yes" ]; then
		echo "building nvidia root"
		docker build -t sl/u18-melodic:nvidia-root -f docker/nvidia/Dockerfile-nvidia-root .
	else
		echo "building cpu root"
		docker build -t sl/u18-melodic:cpu-root -f docker/cpu/Dockerfile-root .
	fi
elif [ "$mode" == "nvidia-user" ]; then
	if [ "$nvidia" == "yes" ]; then
		echo "building nvidia user"
		docker build -t sl/u18-melodic:nvidia-user -f docker/nvidia/Dockerfile-nvidia-user .
	else
		echo "building root user"
		docker build -t sl/u18-melodic:cpu-user -f docker/cpu/Dockerfile-user .
	fi
fi

