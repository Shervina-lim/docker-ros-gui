ROS docker container that can run gui applications

This was created with reference to [docker-ros-box](https://github.com/pierrekilly/docker-ros-box) and [ros docker tutorials](http://wiki.ros.org/docker/Tutorials/GUI).

To use this, docker is sufficient since only using docker run to create containers. No need docker compose.
Please make sure that user is in docker group 

Clone this:

	$ git clone https://github.com/Shervina-lim/docker-ros-gui.git

To create new containers:	
	
	$ ./docker-ros-gui/build.sh [ros-version] [container_name]

### Note: 
 
- user name =  ros

---

Running the container:

	$ ./docker-ros-gui/docker_entry/run.sh [container_name]

Remember to source the bashrc file

	$ source /home/ros/.bashrc
 
Running GUI in container:

Just call the commands as what you do in ubuntu 

Example:

	$ rqt
	$ xclock
	$ glxgears

To open more terminals of the container,run the **run.sh** again.

Removing the container and folder:

	$ ./docker-ros-gui/docker_entry/delete.sh [container_name]

Future:

- Auto source the bashrc file when entering the container
- Add instructions to allow usb devices
- Add instructions to mount volumes


