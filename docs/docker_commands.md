# Useful docker commands

### List images:

	docker image list

### Remove images:

	docker rmi <image_tag> or <image_name>

### List containers: 

	docker ps -a 

### Remove container:

	docker rm <container_name> or <container_tag>
	
### Delete all docker containers and images

	docker system prune -a
	
### Clone docker container 

1. Create an image of the container

		docker commit --message="Snapshot of my container" my_container my_container_snapshot:yymmdd

2. Create a new container with that image

		docker run --name=my_clone my_container_snapshot:yymmdd
	
or can use make_containe.sh but remember to change the **image tag**.

### Copy files into docker

	docker cp file.txt container_name:<desired_location>/file.txt

### Copy files out of docker

	docker cp container_name:/file.txt file.txt

Note both command are executed from your local computer terminal