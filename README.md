# Docker-ros-gui

This is a custom docker image for ros melodic. 

To use this, docker is sufficient since only using docker run to create containers. No need docker compose.

Before using, make sure:

- [nvidia container toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker) is installed
- user is in docker group. Refer to install_docker.md.

## How to use

Clone this:

	git clone https://github.com/Shervina-lim/docker-ros-gui.git

Create custom image:	

	cd docker-ros,gui	
	./script/build.sh nvidia-root


Before creating container, 

- check your network interface device name and change it in make_container.sh 
- modify the no. of cores you want to allow the container to use at **--cpus**
- modify the amount of RAM you want container to use at **--memory-swap**.

Create container:

	./script/make_container.sh [container_name] [root]

**Note:** 

Image already includes the following:

- ros melodic
- terminator
- sublime text
- nvidia drivers 

---

Running the container:

	./script/run.sh [container_name]

Terminator should appear after running container if not just call it. To open more terminals of the container,run the **run.sh** again.

Removing the container and folder:

	$ ./script/delete.sh [container_name]

About container:

- Sharing of usb devices and drives.
- local drive linked to container via docker-ws/[container_name]

Future improvement:

- write one for user