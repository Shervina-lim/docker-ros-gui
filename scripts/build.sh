#!/bin/bash

mode=$1
if [ "$1" == "" ];
then
    echo
    echo "To build custom docker image for ros melodic"
    echo 
    echo "Usage: ./build.sh [mode]"
    echo
    exit 1
else
	echo 
	echo "Building ${mode} image ..."
	echo

	if [ $mode == "nvidia-root" ]; then
		echo "building nvdia root"
		docker build -t sl/u18-melodic:nvidia-root -f docker/Dockerfile-nvidia-root .
	elif [ $mode == "nvidia-user" ]; then
		docker build --build-arg user=$USER -t sl/u18-melodic:nvidia-user -f docker/Dockerfile-nvidia-user .
	fi
fi
