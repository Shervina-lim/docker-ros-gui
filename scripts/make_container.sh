#!/bin/bash

if "$1" == ""
then
    echo
    echo "To create ros docker container with gui enabled"
    echo 
    echo "Usage: ./make_container.sh [container_name] "
    echo
    exit 1
fi

# create container with custom image

name=$1

if [ ! "$(docker ps -q -f name=${name})" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=${name})" ]; then
        # cleanup
        docker rm ${name}
    fi

    XAUTH=/tmp/.docker.xauth

    echo "Preparing Xauthority data..."
    xauth_list=$(xauth nlist :0 | tail -n 1 | sed -e 's/^..../ffff/')
    if [ ! -f $XAUTH ]; then
        if [ ! -z "$xauth_list" ]; then
            echo $xauth_list | xauth -f $XAUTH nmerge -
        else
            touch $XAUTH
        fi
        chmod a+r $XAUTH
    fi

    echo "Done."
    echo ""
    echo "Verifying file contents:"
    file $XAUTH
    echo "--> It should say \"X11 Xauthority data\"."
    echo ""
    echo "Permissions:"
    ls -FAlh $XAUTH
    echo ""
    echo "Running docker..."

    # create directory
    mkdir -p /home/$USER/docker-ws/${name}

    docker run -it --privileged --net=host --ipc=host \
         --name=${name} \
         --env="ROS_IP=$(ip a s dev wlp62s0: | grep -oP 'inet\s+\K[^/]+')" \ 
         --env="DISPLAY=$DISPLAY" \
         --env="QT_X11_NO_MITSHM=1" \
         --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
         --env="XAUTHORITY=$XAUTH" \
         --volume="$XAUTH:$XAUTH" \
         -v="/home/$USER/docker-ws/${name}:/root/${name}" \
         -v="/media/$USER:/media/${name}:rw" \
         -v="/home/$USER/bagfiles:/root/${name}/bagfiles:rw" \
         -v="/dev:/dev:rw" \
         --cpus 16 \
         --memory-swap -1 \
         sl/u18-melodic:nvidia \
         terminator
fi
# check ur network interface device name and switch it with wlp62s0 at the line 52
# --memory-swap -1 = allow max RAM

# saving container id for calling
docker ps -aqf "name=${container_name}" > "${home}/docker-ros-gui/docker_entry/${container_name}/containerId.txt"
rm -rf ${home}/docker-ros-gui/docker/cp-bashrc

echo ""
echo "Container is create!"
echo ""
echo "Command to start container: ./scripts/run.sh ${container_name}"
echo "Command to delete container: ./scripts/delete.sh ${container_name}"

    