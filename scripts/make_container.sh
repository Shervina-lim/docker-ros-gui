#!/bin/bash

if [ "$2" == "" ];
then
    echo
    echo "To create ros docker container with gui enabled"
    echo 
    echo "Usage: ./make_container.sh [container_name] [mode] [cpu] [ram]"
    echo
    echo "Mode: nvidia-root, nvidia-user, cpu-root, cpu-user"
    echo 
    echo "Cpu: choose how much core you give docker"
    echo "Default = 16"
    echo
    echo "Ram: choose how much ram for docker"
    echo "Format: <number><<unit>, eg 10g -> 10 gb "
    echo "Default = -1"
    echo
    exit 1
fi

# set variables
name=$1
user=$2

if [ "$3" == "" ]; then
    cpu=16
else
    cpu=$3
fi

if [ "$4" == "" ]; then
    ram=-1
else
    ram=$3
fi

# remove existing container with same name
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

    # check ur network interface device name and switch it with wlo1 at the line 52
    # --memory-swap -1 = allow max RAM
    # remove -v="/home/$USER/bagfiles:/home/${user}/bagfiles:rw"
    if [ $user == "nvidia-root" ]; then
        docker run -it --privileged --net=host --ipc=host \
             --name=${name} \
             --env="ROS_IP=$(ip a s dev wlo1 | grep -oP 'inet\s+\K[^/]+')" \
             --env="DISPLAY=$DISPLAY" \
             --env="QT_X11_NO_MITSHM=1" \
             -v="/home/$USER/docker-ws/${name}:/root" \
             -v="/home/$USER/bagfiles:/root/bagfiles:rw" \
             -v="/dev:/dev:rw" \
             --cpus ${cpu} \
             --memory-swap ${ram}\
             --runtime=nvidia \
             sl/u18-melodic:nvidia-root \
             terminator

## also can look into how to make new user
    elif [ $user == "nvidia-user" ]; then
        docker run -it --privileged --net=host --ipc=host \
             --name=${name} \
             --env="ROS_IP=$(ip a s dev wlo1 | grep -oP 'inet\s+\K[^/]+')" \
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
             --memory-swap ${ram}\
             --runtime=nvidia \
             sl/u18-melodic:nvidia-user \
             terminator

     elif [ $user == "cpu-root" ]; then
        docker run -it --privileged --net=host --ipc=host \
             --name=${name} \
             --env="ROS_IP=$(ip a s dev wlo1 | grep -oP 'inet\s+\K[^/]+')" \
             --env="DISPLAY=$DISPLAY" \
             --env="QT_X11_NO_MITSHM=1" \
             -v="/home/$USER/docker-ws/${name}:/root" \
             -v="/home/$USER/bagfiles:/root/bagfiles:rw" \
             -v="/dev:/dev:rw" \
             --cpus ${cpu} \
             --memory-swap ${ram}\
             sl/u18-melodic:cpu-root \
             terminator

    elif [ $user == "cpu-user" ]; then
    docker run -it --privileged --net=host --ipc=host \
         --name=${name} \
         --env="ROS_IP=$(ip a s dev wlo1 | grep -oP 'inet\s+\K[^/]+')" \
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
         --memory-swap ${ram}\
         sl/u18-melodic:cpu-user \
         terminator
    fi
fi  

echo 
echo "Start container: ./scripts/run.sh ${name}"
echo "Delete container: ./scripts/delete.sh ${name}"
echo 