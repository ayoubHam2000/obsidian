#docker #webDev/docker
docker commands:
- docker pull
- docker run
	- docker run -d \[container_name:version\]
		- docker run will pull the image and starts the container
	* docker run -p\[host_port\]:\[containre_port\]
	* docker run --name \[give a name to a container\]
	* docker run -e \[env\]
	* docker run --net \[network name\]
- docker start
	- docker start id
- docker stop
	- docker stop id
- docker ps
	- docker ps -a
- docker logs
	- docker logs \[container_id\] **to display the container log**
	- docker logs \[container_name\]
- docker exec -it
	- get the terminal of the container -it stands for interactive terminal 
- docker images
- docker network
	- docker network ls
	- docker network create \[name\]
* docker-compose -f \[FileOutname\] down
* docker-compose -f \[FileOutname\] up -d
* docker build
	* docker build -t `[name]`:`[tag]` `[dockerFileDir]`
* docker rm `[containerId]`
* docker rmi `[ImageId]`
* docker tag
	* docker tag `[imageName]` `[tag/imageName]`  [docker_tutorial:2h:17](https://www.youtube.com/watch?v=3c-iBn73dDE&t=2910s&ab_channel=TechWorldwithNana)
* docker push
	* docker push `[imageName]` default repositry is docker hup  [docker_tutorial:2h:17](https://www.youtube.com/watch?v=3c-iBn73dDE&t=2910s&ab_channel=TechWorldwithNana)

> what is a container ?

containers are a running envirement of an image
containers have _virtual file system_, _prot binded_ to them

> difference between run and start

docker start for start a container or restart the container with same state, docker run will create a new container from the image

![[Jenkins_logo.svg|50]]Jenkins : builds APP & create docker image 

> Buildind Docker Image

https://www.youtube.com/watch?v=3c-iBn73dDE&t=2910s&ab_channel=TechWorldwithNana

summary: after creating a nodejs app we will create a Dockerfile that will used to create the docker image using `docker build`.
link to the app code
https://gitlab.com/nanuchi/techworld-js-docker-demo-app

example of a docker file to build the above app:

```C
FROM node:13-alpine //the base image the node image has also a base image inside it's docker file you can see the source code

  
//Set the envirement variable
ENV MONGO_DB_USERNAME=admin \

MONGO_DB_PWD=password

  
//run a bash or sh command in the container side
RUN mkdir -p /home/app

  
//copt from host machine to container 
COPY ./app /home/app

  

# set default dir so that next commands executes in /home/app dir
WORKDIR /home/app

  

# will execute npm install in /home/app because of WORKDIR
RUN npm install

  

# no need for /home/app/server.js because of WORKDIR
CMD ["node", "server.js"]
```

> Private Docker Repository

example AWS ECR
* Images  naming in Docker registries
	registryDomain/imageName:tag
	by default the `registryDomain` is dockerHup 
	`docker pull mongo:1.0` it will be `docker pull docker.io/library/mongo:1.0`

> what is the Docker Volume ?

A Docker volume is a way to store data outside of a Docker container's filesystem. Volumes can be used to persist data, even if the container is deleted or recreated. They allow to separate the data of an application from the container, which can be useful for many reasons. This can include sharing data between containers, storing data on the host's filesystem, or making data available to other processes running on the host.
When you create a volume, it does not exist on the host's filesystem, but it's tracked by the Docker daemon. When a container uses a volume, the Docker daemon will create the volume if it does not exist, and the files in the volume will be visible to the container at the specified mount point.

Docker volumes can be created and managed using the `docker volume` command. You can create a volume using the `docker volume create` command. For example:
```c
docker volume create my-volume
```
When you create a container, you can use the `--mount` or `-v` option to attach a volume to a container's filesystem.
```C
docker run -it --name mycontainer -v my-volume:/app/data myimage
```
This command creates a container named "mycontainer" and mounts the volume "my-volume" to the directory "/app/data" in the container. Any files written to the /app/data directory inside the container will be stored in the "my-volume" volume.
It is important to note that, as soon as you delete a container that uses a volume, the data stored in the volume is not deleted. This is useful when you want to keep data between container restarts. However, if the volume is not used by any container, you can use `docker volume rm` to remove the volume.
 
- there is three type of volumes  `Host Volume`s , `Anonymous Volumes`, `Named Valumes`
	- docker -v `HostVolumePath`:`ContainerVolumePath` ..
	- docker -v `ContainerValumePath` ..
	- docker -v `name`:`ContainerValumePath` ..

> docker-compose yaml file example

```js
version: '3'

services:

# my-app:

# image: ${docker-registry}/my-app:1.0

# ports:

# - 3000:3000

mongodb:

image: mongo

ports:

- 27017:27017

environment:

- MONGO_INITDB_ROOT_USERNAME=admin

- MONGO_INITDB_ROOT_PASSWORD=password

volumes:

- mongo-data:/data/db

mongo-express:

image: mongo-express

restart: always # fixes MongoNetworkError when mongodb is not ready when mongo-express starts

ports:

- 8080:8081

environment:

- ME_CONFIG_MONGODB_ADMINUSERNAME=admin

- ME_CONFIG_MONGODB_ADMINPASSWORD=password

- ME_CONFIG_MONGODB_SERVER=mongodb

volumes:

mongo-data:

driver: local

```
