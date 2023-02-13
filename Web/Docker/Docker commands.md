#docker #webDev/docker #commands/docker
# docker
* docker pull
- docker run
	- docker run `[image_name:tag]` `[commands to the terminal]`
	- docker run -d `[image_name:tag]`
		- docker run will pull the image and starts the container
	- docker run -it **i for interactive and t for pseudo terminal**
	* docker run -p\[host_port\]:\[containre_port\]
	* docker run --name \[give a name to a container\]
	* docker run -e `[env(name=value)]`
	* docker run --net \[network name\]
	* docker run -v `[hostFolder]:[containerFolder]` `[container:tag]` **binding**
	* docker run -v `[VolumeName]:[containerFolder]` `[container:tag]` **mounting**
	* docker run -v `[containerFolder]` `[container:tag]` 
	* docker run --mount type=bind, source=`[sourceFolder]`, target=`[targetFolder]` `[container:tag]`
	* docker run --network=`[none|host]`
	* docker run ... --link `[ContainerName]:[HostName]`
	* docker -H `address` run ...
	* docker run --cpu=.5 ... **use 50% cpu**
	* docker run --memory=100m ... **use 100m of Ram as a limit**
* docker inspect
	* docker inspect `[container:tag]`
* docker attach
	* **the reverse of docker -d**
- docker start
	- docker start id
- docker stop
	- docker stop id
- docker ps
	- docker ps -a
- docker logs
	- docker logs \[container_id\] **to display the container log**
	- docker logs \[container_name\]
- docker exec
	- docker exec -it `:get the terminal of the container -it stands for interactive terminal `
	- docker exec `[name]` `[command]` `:run a command inside the container`
- docker images
- docker image
	- docker image build -t myapp .
- docker volume
	- docker volume create `[name]`
- docker network
	- docker network ls
	- docker network create \[name\]
	- docker network create --driver bridge --subnet `[subnet]` `[name]`
* docker-compose -f \[FileOutname\] down
* docker-compose -f \[FileOutname\] up -d
* docker build
	* docker build -t `[name]`:`[tag]` `[dockerFileDir]`
* docker rm `[containerId]`
* docker rmi `[ImageId]`
* docker tag
	* docker tag `[imageName]` `[tag/imageName]`  [docker_tutorial:2h:17](https://www.youtube.com/watch?v=3c-iBn73dDE&t=2910s&ab_channel=TechWorldwithNana) **you can push to local registry**
* docker push
	* docker push `[imageName]` default repositry is docker hup  [docker_tutorial:2h:17](https://www.youtube.com/watch?v=3c-iBn73dDE&t=2910s&ab_channel=TechWorldwithNana)
* docker login
	* docker login `[registry]`


# DockerFile
* FROM `ImagName`
* RUN
* COPY
* ENTRYPOINT