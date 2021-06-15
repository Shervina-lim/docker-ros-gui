# Installation guide for docker 

## Install docker
Setting up the repo
1. Update the apt package index and install packages to allow apt to use a repository over HTTPS:

		sudo apt-get update
		
		sudo apt-get install \
    	  apt-transport-https \
    	  ca-certificates \
    	  curl \
    	  gnupg-agent \
    	  software-properties-common

2. Add Docker’s official GPG key:
	
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

3. Verify is fingerprints are 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88

		sudo apt-key fingerprint 0EBFCD88

4. Setup stable repo (for ubuntu x64)

		sudo add-apt-repository \
		"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
		$(lsb_release -cs) \
		stable"

Installing Docker engine

 	sudo apt-get update
 	sudo apt-get install docker-ce docker-ce-cli containerd.io

Verify if Docker is installed:

	sudo docker run hello-world

Source:https://docs.docker.com/engine/install/ubuntu/ 


Giving Docker root permission:

	sudo groupadd docker
	sudo usermod -aG docker ${USER}
	newgrp docker

Check using:

	docker run hello-world

Source:https://stackoverflow.com/questions/48957195/how-to-fix-docker-got-permission-denied-issue


Get [Docker images](https://hub.docker.com/search?q=&type=image) and [Ros images](https://registry.hub.docker.com/_/ros/)

## Install nvidia container toolkit


		distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
   
	curl -s -L https://nvidia.github.io/nvidia-container-runtime/experimental/$distribution/nvidia-container-runtime.list | sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
	
	sudo apt-get update
	sudo apt-get install -y nvidia-docker2
	sudo systemctl restart docker
	
### Testing installation 

Run this:

	sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
	
If you see the following, the installation is good.

	+-----------------------------------------------------------------------------+
	| NVIDIA-SMI 450.51.06    Driver Version: 450.51.06    CUDA Version: 11.0     |
	|-------------------------------+----------------------+----------------------+
	| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
	| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
	|                               |                      |               MIG M. |
	|===============================+======================+======================|
	|   0  Tesla T4            On   | 00000000:00:1E.0 Off |                    0 |
	| N/A   34C    P8     9W /  70W |      0MiB / 15109MiB |      0%      Default |
	|                               |                      |                  N/A |
	+-------------------------------+----------------------+----------------------+

	+-----------------------------------------------------------------------------+
	| Processes:                                                                  |
	|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
	|        ID   ID                                                   Usage      |
	|=============================================================================|
	|  No running processes found                                                 |
	+-----------------------------------------------------------------------------+
	

