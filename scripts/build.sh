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

	if [ $mode == "nvidia-root" ]; then
		echo "building nvidia root"
		if [ $nvidia == "yes" ]; then
			docker build -t sl/u18-melodic:nvidia-root -f docker/nvidia/Dockerfile-nvidia-root .
		else
			docker build -t sl/u18-melodic:cpu-root -f docker/cpu/Dockerfile-root .
		fi
	elif [ $mode == "nvidia-user" ]; then
		echo "building nvidia user"
		if [ $nvidia == "yes" ]; then
			docker build -t sl/u18-melodic:nvidia-user -f docker/nvidia/Dockerfile-nvidia-user .
		else
			docker build -t sl/u18-melodic:cpu-user -f docker/cpu/Dockerfile-user .
		fi
	fi
fi
