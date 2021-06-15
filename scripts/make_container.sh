#!/bin/bash

if [ "$2" == "" ];
then
    echo
    echo "To create ros docker container with gui enabled"
    echo 
    echo "Usage: ./make_container.sh [container_name] [mode] [cpu] [ram]"
    echo "Mode: nvidia-root, nvidia-user, cpu-root, cpu-user"
    echo "Cpu: choose how much core you give docker, default = 16"
    echo "Ram: choose how much ram for docker, default = 15g"
    echo
    exit 1
fi

# create container with custom image

name=$1
user=$2

if [ "$3" == "" ]; then
    cpu=16
else
    cpu=$3

if [ "$4" == "" ]; then
    ram=15g
else
    ram=$3


if [ ! "$(docker ps -q -f name=${name})" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=${name})" ]; then
        # cleanup
        docker rm ${name}
    fi

    # create directory
    mkdir -p /home/$USER/docker-ws/${name}
    # copy Terminator Config and bashrc 
    mkdir -p /home/$USER/docker-ws/${name}/.config/terminator/
    cp /home/$USER/docker-ros-gui/docker/config/terminator_config /home/$USER/docker-ws/${name}/.config/terminator/config 
    cp /home/$USER/docker-ros-gui/docker/config/bashrc /home/$USER/docker-ws/${name}/.bashrc

    # check ur network interface device name and switch it with wlp62s0 at the line 52
    # --memory-swap -1 = allow max RAM
    # remove -v="/home/$USER/bagfiles:/home/${user}/bagfiles:rw"
    if [ $user == "nvidia-root" ]; then
        docker run -it --privileged --net=host --ipc=host \
             --name=${name} \
             --env="ROS_IP=$(ip a s dev wlp62s0 | grep -oP 'inet\s+\K[^/]+')" \
             --env="DISPLAY=$DISPLAY" \
             --env="QT_X11_NO_MITSHM=1" \
             -v="/home/$USER/docker-ws/${name}:/root" \
             -v="/home/$USER/bagfiles:/root/bagfiles:rw" \
             -v="/dev:/dev:rw" \
             --cpus ${cpu} \
             -m ${ram} \
             --runtime=nvidia \
             sl/u18-melodic:nvidia-root \
             terminator

## also can look into how to make new user
    elif [ $user == "nvidia-user" ]; then
        docker run -it --privileged --net=host --ipc=host \
             --name=${name} \
             --env="ROS_IP=$(ip a s dev wlp62s0 | grep -oP 'inet\s+\K[^/]+')" \
             --env="DISPLAY=$DISPLAY" \
             --env="QT_X11_NO_MITSHM=1" \
             -v="/home/$USER/docker-ws/${name}:/home/${user}" \
             -v="/home/$USER/bagfiles:/home/${user}/bagfiles:rw" \
             -v="/dev:/dev:rw" \
             --user=$(id -u $USER):$(id -g $USER) \
             --env="DISPLAY" \
             --volume="/etc/group:/etc/group:ro" \
             --volume="/etc/passwd:/etc/passwd:ro" \
             --volume="/etc/shadow:/etc/shadow:ro" \
             --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
             --cpus ${cpu} \
             -m ${ram} \
             --runtime=nvidia \
             sl/u18-melodic:nvidia-user \
             terminator

     elif [ $user == "cpu-root" ]; then
        docker run -it --privileged --net=host --ipc=host \
             --name=${name} \
             --env="ROS_IP=$(ip a s dev wlp62s0 | grep -oP 'inet\s+\K[^/]+')" \
             --env="DISPLAY=$DISPLAY" \
             --env="QT_X11_NO_MITSHM=1" \
             -v="/home/$USER/docker-ws/${name}:/home/${user}" \
             -v="/home/$USER/bagfiles:/home/${user}/bagfiles:rw" \
             -v="/dev:/dev:rw" \
             --user=$(id -u $USER):$(id -g $USER) \
             --env="DISPLAY" \
             --volume="/etc/group:/etc/group:ro" \
             --volume="/etc/passwd:/etc/passwd:ro" \
             --volume="/etc/shadow:/etc/shadow:ro" \
             --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
             --cpus ${cpu} \
             -m ${ram} \
             --runtime=nvidia \
             sl/u18-melodic:nvidia-user \
             terminator

    elif [ $user == "cpu-user" ]; then
    docker run -it --privileged --net=host --ipc=host \
         --name=${name} \
         --env="ROS_IP=$(ip a s dev wlp62s0 | grep -oP 'inet\s+\K[^/]+')" \
         --env="DISPLAY=$DISPLAY" \
         --env="QT_X11_NO_MITSHM=1" \
         -v="/home/$USER/docker-ws/${name}:/home/${user}" \
         -v="/home/$USER/bagfiles:/home/${user}/bagfiles:rw" \
         -v="/dev:/dev:rw" \
         --user=$(id -u $USER):$(id -g $USER) \
         --env="DISPLAY" \
         --volume="/etc/group:/etc/group:ro" \
         --volume="/etc/passwd:/etc/passwd:ro" \
         --volume="/etc/shadow:/etc/shadow:ro" \
         --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
         --cpus ${cpu} \
         -m ${ram} \
         --runtime=nvidia \
         sl/u18-melodic:nvidia-user \
         terminator
    fi
fi  

echo 
echo "Start container: ./scripts/run.sh ${name}"
echo "Delete container: ./scripts/delete.sh ${name}"
echo 