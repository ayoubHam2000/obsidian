## Buildind Docker Image

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

## Private Docker Repository

example AWS ECR
* Images  naming in Docker registries
	registryDomain/imageName:tag
	by default the `registryDomain` is dockerHup 
	`docker pull mongo:1.0` it will be `docker pull docker.io/library/mongo:1.0`


## docker-compose yaml file example

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