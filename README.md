# Docker-ros-gui

This is a custom docker image for ros melodic. 

To use this, docker is sufficient since only using docker run to create containers. No need docker compose.

## Prerequesites

Before using, make sure:

- [nvidia container toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker) is installed
- user is in docker group. Refer to install_docker.md.

## How to install

Clone this:

	git clone https://github.com/Shervina-lim/docker-ros-gui.git

#### Create custom image:	

	cd docker-ros,gui	
	./script/build.sh nvidia-root


#### Before creating container, 

- check your network interface device name and change it in make_container.sh. Can use either ethernet or wifi one. If you don't set this, you have to manually export ROS_IP for roscore to work. 
- modify the no. of cores you want to allow the container to use at **--cpus**
- modify the amount of RAM you want container to use at **--memory-swap**.

#### Create container:

	./script/make_container.sh [container_name] [root]

#### Installed Packages 

- ros melodic
- terminator
- sublime text
- nvidia drivers 

---

## How to use:

#### Running the container:

	./script/run.sh [container_name]

Terminator should appear after running container if not just call it. To open more terminals of the container,run the **run.sh** again.

#### Removing the container and folder:

	$ ./script/delete.sh [container_name]

#### Things to note regarding container:

- Sharing of usb devices and drives.
- local drive linked to container via docker-ws/[container_name]

#### Sharing external drives:

Check drive name 

	lsblk 

External drives are usually named sd_. For my case, sdc1.

Mount drive

	mount /dev/sdc1 /media/<container_name>

#### Some known problems

1. Folder read only issue

Although you can see the files from file explorer in /docker-ws/<container_name>, but they are just read only. You also cannot move or copy file to and from the folder as it requires **root** permissions. This is because we run the container as **root**

To have read and write rights for those folders, need to do it within terminal or use the following command to make it editable. I have already add this to run.sh.

	sudo chown -R $USER:$USER ~/docker-ws/<container_name>

2. Roscore not working

You may find roscore not working when you change network. If so, you have to maunally export ros ip again. Run ```export ROS_IP=localhost```. Also you can just modify the make_container.sh to use localhost to prevent this issue 

	--env="ROS_IP=localhost"\


## Future improvement:

- Write one for user = yourself. See if can solve the read only problem
- See if any easy way to create custom user for each container. eg. user = "vio", "vm". so, no sharing of user. May be the solution to open mulitple containers. 
- Write some scripts to install vios, kalir, docker for easy setup at new computers
- Find a way to allow users to open multiple containers. Now using user == root, I only can open one container at a time. so, cannot multitask. Maybe cos they are all sharing the same "user" which cause this to happen.
- Edit my own vio fork for easy transfer of config files.
