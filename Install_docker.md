Download docker using the following instructions:

Setting up the repo

1. Update the apt package index and install packages to allow apt to use a repository over HTTPS:

	$ sudo apt-get update

	$ sudo apt-get install \
    	  apt-transport-https \
    	  ca-certificates \
    	  curl \
    	  gnupg-agent \
    	  software-properties-common

2. Add Docker’s official GPG key:

	$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

3. Verify is fingerprints are 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88

	$ sudo apt-key fingerprint 0EBFCD88

4. Setup stable repo (for ubuntu x64)

	$ sudo add-apt-repository \
   	  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   	  $(lsb_release -cs) \
   	  stable"

Installing Docker engine

 	$ sudo apt-get update
 	$ sudo apt-get install docker-ce docker-ce-cli containerd.io

Verify if Docker is installed:

	$ sudo docker run hello-world

Source:https://docs.docker.com/engine/install/ubuntu/ 


Giving Docker root permission:

	$ sudo groupadd docker
	$ sudo usermod -aG docker ${USER}
	$ newgrp docker

Check using:

	$ docker run hello-world

Source:https://stackoverflow.com/questions/48957195/how-to-fix-docker-got-permission-denied-issue

Download Docker Compose:

1. Download current stable release of Docker Compose:

	$ sudo curl -L "https://github.com/docker/compose/releases/download/1.27.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

2. Apply executeable permissions:

	$ sudo chmod +x /usr/local/bin/docker-compose

3. Test docker compose

	$ docker-compose --version

Get Docker images from: https://hub.docker.com/search?q=&type=image

Ros images: https://registry.hub.docker.com/_/ros/

To use them: 

	$ docker pull image ubuntu:<distro> 
Remove:

	$ docker rmi <image id>

The containers that uses the image has to be deleted before removing the image

Error: image has dependent child images

Solution: Remove unneccessary images before removing the image
	
	$ docker rmi $(docker images --filter "dangling=true" -q --no-trunc)

Source: https://stackoverflow.com/questions/38118791/can-t-delete-docker-image-with-dependent-child-images




