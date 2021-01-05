ROS docker container that can run gui applications

This was created with reference to [docker-ros-box](https://github.com/pierrekilly/docker-ros-box) and [ros docker tutorials](http://wiki.ros.org/docker/Tutorials/GUI).

To use this, docker is sufficient since only using docker run to create containers. No need docker compose.
Please make sure that user is in docker group

Clone this:

	$ git clone https://github.com/Shervina-lim/docker-ros-gui.git

To create new containers:	
	
	$ sudo ./docker-ros-melodic/build.sh [ros-version] [container_name]

### Note: 

- container_name = file_name 
- user name =  <container_name>-dev
- Src folder in ~/<file_name>/src is linked. Can use this to transfer files between container and local.

---

Running the container:

	$ cd [file_name]
	$ ./go.sh

Running GUI in container:

Just call the commands as what you do in ubuntu 

Example:

	$ rqt
	$ xclock
	$ glxgears

To open more terminals of the container, run the go.sh file again in a new terminal.


