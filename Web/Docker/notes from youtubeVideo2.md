## What is Docker
Docker is a platform that allows developers to easily deploy and run applications in containers. Containers are lightweight, portable environments that can run on any system with a Docker engine installed, making it easy to move applications between different environments. Docker provides a simple and consistent way to package and distribute applications, making it a popular choice for developers and system administrators.

## what are containers
Containers are a form of operating system virtualization that allow multiple isolated environments to run on a single host system. Each container runs its own copy of an operating system, but shares the host system's kernel. This allows containers to be lightweight and efficient, as they don't require a full operating system to be installed for each application. Containers also provide a consistent environment for applications, making it easy to move them between different systems. This enables developers to easily test and deploy their applications in different environments. They are often used to package and distribute applications in a way that makes them easy to run and manage on different systems.

## why we want isolated environments ?
Isolated environments are important for several reasons:

1.  Security: By running applications in isolated environments, it can help prevent one application from accessing or modifying the resources of another. This can help to prevent malicious software or bugs from spreading or causing damage to other applications.
    
2.  Resource management: Containers allow different applications to run on the same host system while still isolating their resources. This can help to ensure that each application has the resources it needs to run properly, and prevent one application from monopolizing resources and causing other applications to fail.
    
3.  Dependency management: Isolated environments make it easy to manage the dependencies of different applications. Each container can have its own set of dependencies and libraries, which eliminates conflicts and makes it easy to run multiple versions of the same application.
    
4.  Reproducibility: Isolated environments make it easy to reproduce a specific version of an application, as all of its dependencies are bundled together in the container. This helps to ensure that the application will work the same way in different environments.
    
5.  Portability: Because containers are isolated from the host system and from each other, they are highly portable, allowing the same container to be easily moved between different systems, whether development, test or production environments.

## what do you mean with "moved between different systems"

When I say "moved between different systems", I mean that a containerized application can be easily moved and run on different host systems, regardless of the underlying infrastructure. Because containers include all of the application's dependencies and configurations, they can run consistently across different environments.

For example, a containerized application can be developed on a developer's laptop, then tested on a staging server, and finally deployed to a production environment, all without any modification. The container encapsulates all the dependencies and configurations the application needs in order to run, ensuring that the application will run the same way on each system.

This is a major advantage of using containers, as it allows for more efficient and faster deployment, as well as greater consistency across different environments.

## by different systems you means systems with different environments, what about different operating system ?

Yes, by "different systems" I also mean systems with different operating systems. Containers provide a consistent environment for applications, regardless of the underlying operating system. This means that a containerized application can be run on any system that has a Docker engine installed, regardless of whether the host system is running Windows, Linux, or macOS.

For example, a containerized application that was developed on a Linux system can be easily run on a Windows system, or vice versa, without the need to make any changes to the application's code or dependencies. This is possible because the container includes its own copy of the operating system and dependencies, which are isolated from the host system.

This makes containers a very powerful tool for developers, as it allows them to easily test and deploy their applications on different systems and operating systems, without the need to worry about compatibility issues.

## how it can be that the container includes its own copy of the operating system

Containers are built on top of the host operating system's kernel, they do not include their own full copy of the operating system. Instead, they use the host system's kernel and share the host system's resources such as the file system, network stack and memory.

Each container has its own file system, and this file system is built using a layered approach. The base of the file system is the host system's file system and on top of it, the container has its own file system that includes the application and its dependencies.

This layered file system allows multiple containers to share the same base image and only include the changes specific to their own container. This makes containers lightweight and efficient, as they don't need to include a full copy of the operating system for each application.

That's why container images are smaller compared to virtual machine images and the reason why they are faster to start and use fewer resources.

In summary, containers do not include their own full copy of the operating system but they share the host operating system kernel and use a layered file system approach to include only the necessary files and dependencies for the application.

## if an application work on linux and uses the linux kernel how it can then understand the windows or mac kernel ?

When a containerized application is run on a Windows or macOS host system, the host system's Docker engine provides a compatibility layer that allows the Linux-based container to communicate with the host system's kernel. This compatibility layer is called the Docker Engine API. It allows the containerized application to use the Linux kernel system calls and system libraries, while still being able to interact with the host system's resources, such as the file system and network stack.

Additionally, in order to run Linux-based container on Windows or macOS, Docker uses a technology called "Linux Kit" on Windows and "HyperKit" on macOS. This technology allows the host to run a lightweight virtual machine that provides a minimal Linux environment. The Linux container runs inside this virtual machine and this provides compatibility with the Linux kernel system calls and libraries required by the container.

It is important to note that the containerized application runs on top of the host system's kernel and not directly on the hardware. Therefore, the application is isolated from the host system and does not have direct access to the hardware resources.

In summary, the Docker Engine API and the Linux Kit/HyperKit technology provide compatibility between the containerized Linux-based application and the host system's kernel, allowing the application to run on different operating systems.

## why we need containers and docker

Containers and Docker are useful for several reasons:

1.  Consistency: Containers provide a consistent environment for applications, making it easy to move them between different systems. This allows developers to easily test and deploy their applications in different environments.
    
2.  Portability: Containers are lightweight and portable, making it easy to move them between different systems, whether development, test or production environments.
    
3.  Efficiency: Containers use fewer resources than traditional virtual machines, as they share the host system's kernel and use a layered file system approach to include only the necessary files and dependencies for the application.
    
4.  Scalability: Docker provides a simple and consistent way to manage containers, making it easy to scale applications up or down as needed.
    
5.  Isolation: Containers provide a level of isolation between applications, which can help to prevent malicious software or bugs from spreading or causing damage to other applications.
    
6.  Resource management: Containers allow different applications to run on the same host system while still isolating their resources. This can help to ensure that each application has the resources it needs to run properly, and prevent one application from monopolizing resources and causing other applications to fail.
    
7.  Version management: Containers make it easy to manage the dependencies of different applications, allowing multiple versions of the same application to run on the same host.
    
8.  Automation: Docker provides a set of tools and APIs to automate the deployment, scaling, and management of containerized applications, reducing the complexity and effort required to run and manage applications.
    

In summary, Containers and Docker are powerful tools that provide consistency, portability, efficiency, scalability, isolation, resource management, version management, and automation, making it easy to develop, test, and deploy applications in different environments.

## what is docker image

A Docker image is a pre-built package that contains all the files, configuration, and dependencies needed to run a specific application or service. It is the building block of a containerized application, and it can be thought of as a snapshot of an application and its dependencies at a specific point in time.

Docker images are created using a series of instructions called a Dockerfile. The Dockerfile is a text file that contains instructions on how to build the image, such as which base image to use, which files to copy, and which commands to run.

Once an image is built, it can be stored in a registry, such as Docker Hub, and can be easily shared and distributed to other developers or systems.

Images can be pulled from the registry and used to create new containers. They can also be used to update an existing container by creating a new container with the updated image and then replacing the old container with the new one.

Docker images are also layered, meaning that they can build on top of other images, allowing multiple images to share a common base image. This makes images lightweight and efficient as they don't need to include a full copy of the operating system or dependencies for each application.

In summary, a Docker image is a pre-built package that contains all the files, configuration, and dependencies needed to run a specific application or service, it's built using a series of instructions called a Dockerfile and can be stored in a registry and shared with other developers.

## Docker volume mapping

Docker volume mapping is a feature that allows you to map a directory on the host machine to a directory in a container. This allows you to persist data outside of the container's filesystem, which can be useful in several scenarios.

For example, if you have a container running a database, you can map the container's data directory to a directory on the host machine. This allows you to persist the data even if the container is deleted or recreated.

Another use case is when you want to share files between the host machine and the container. By mapping a directory on the host machine to a directory inside the container, you can easily share files between them.

To create a volume mapping, you can use the `-v` or `--volume` flag when running the `docker run` command.

## dockerFile

A Dockerfile is a text file that contains instructions on how to build a Docker image. It is used to automate the process of creating an image, and it is the building block of a containerized application.

A Dockerfile typically starts with a base image, on top of which you can add additional files, run commands, and make other modifications. The Dockerfile is processed by the Docker engine, which reads each instruction and performs the corresponding action.
Here is an example of a simple Dockerfile:
```bash
FROM ubuntu:20.04

RUN apt-get update && apt-get install -y nginx

COPY index.html /var/www/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

```

## Most commonly used instructions in a Dockerfile

The most commonly used instructions in a Dockerfile and a brief description of what they do:

-   `FROM`: Specifies the base image to use for the build. This instruction must be the first instruction in the Dockerfile.
    
-   `RUN`: Runs a command in the container. This instruction is used to install packages, run scripts, and perform other actions during the build process.
    
-   `COPY`: Copies files from the host machine to the container. This instruction is used to add application files, scripts, and other resources to the container.
    
-   `ENV`: Sets an environment variable in the container. This instruction is used to configure the container with environment-specific settings.
    
-   `EXPOSE`: Specifies the ports that should be exposed by the container. This instruction is used to make the container accessible on the network.
    
-   `CMD`: Specifies the command that should be run when the container starts. This instruction is used to run the application or service inside the container.
    
-   `ENTRYPOINT`: Specifies the command that should be run when the container starts. This instruction is used to configure the container to run as an executable.
    
-   `VOLUME`: Creates a mount point for a volume in the container. This instruction is used to persist data outside of the container's filesystem.
    
-   `USER`: Sets the user and group that the container should run as. This instruction is used to configure the container with the appropriate permissions.
    
-   `WORKDIR`: Sets the working directory for the container. This instruction is used to configure the container with the appropriate file paths.
    
-   `LABEL`: Adds metadata to the image in the form of key-value pairs. This instruction is used to provide additional information about the image.

## Layered architecture of docker to build an image

Docker uses a layered architecture to build images. Each layer represents a change or modification made to the image, and it is identified by a unique hash.

The process of building an image starts with a base image, which is the foundation of the image. The base image can be an official image from a registry, such as Docker Hub, or it can be a custom image that you have created yourself.

On top of the base image, you can add additional files, run commands, and make other modifications. Each change or modification is represented by a new layer, and it is added on top of the previous layers.

For example, imagine you are building an image for a web application that runs on Apache. You start with a base image of Ubuntu, and then you add the Apache web server and your application files. Each of these changes is represented by a new layer.

The layers are stored in a cache, which allows Docker to reuse layers from previous builds, rather than having to rebuild them from scratch.

When you run a container from an image, Docker uses a read-only file system to mount the layers together, creating a single unified file system for the container.

This layered architecture allows Docker to create images that are lightweight and efficient, as they don't need to include a full copy of the operating system or dependencies for each application.

In summary, Docker uses a layered architecture to build images, each layer represents a change or modification made to the image, the base image is the foundation of the image, layers are stored in a cache and when running a container all the layers are mounted together to create a single unified file system for the container.

## The read and write layer in docker

In Docker, the read-write layer is the topmost layer of a container's filesystem. It is also known as the "container layer" or "container writable layer".

This layer is where all the changes made inside the container are stored. Every time a container makes a change to the file system, such as creating, modifying or deleting a file, that change is stored in the read-write layer.

The read-write layer sits on top of the other layers of the container's filesystem, which are read-only. These layers are built from the image that the container is created from, and they contain the application and its dependencies.

When a container starts, Docker creates a read-write layer for the container and mounts it on top of the other layers. This allows the container to make changes to the file system, such as creating or modifying files, while still being isolated from the host system.

It's worth noting that when a container is deleted, the changes made in the read-write layer are also deleted, unless you use a volume or a bind mount to persist the data.

In summary, the read-write layer in Docker, also known as container layer, is the topmost layer of a container's filesystem where all the changes made inside the container are stored and it sits on top of the other read-only layers that are built from the image the container is created from.

## The read-only layers

The other layers in a container's filesystem are the read-only layers. They are built from the image that the container is created from and they contain the application and its dependencies.

Docker uses a layered architecture to build images. Each layer represents a change or modification made to the image, and it is identified by a unique hash. This allows Docker to create images that are lightweight and efficient, as they don't need to include a full copy of the operating system or dependencies for each application.

Each image is made up of multiple layers, including the base image layer, which is the foundation of the image, and additional layers that are added on top of the base image layer. These additional layers represent the changes or modifications made to the image, such as installing software, copying files, and running scripts.

Each layer is built on top of the previous one and the layers are stored in a cache, which allows Docker to reuse layers from previous builds, rather than having to rebuild them from scratch.

When you run a container from an image, Docker uses a read-only file system to mount the layers together, creating a single unified file system for the container. This unified file system is composed of all the read-only layers of the image, and the read-write layer that is created when the container starts.

In summary, the other layers in a container's filesystem are the read-only layers that are built from the image the container is created from. These layers contain the application and its dependencies and they are stored in a cache, allowing Docker to reuse them from previous builds, and when the container starts, these layers are mounted together with the read-write layer to create a single unified filesystem for the container.

## To persist data inside a container

If you want to persist data inside a container, you have a couple of options:

1.  **Docker Volumes**: You can use the `-v` or `--volume` flag when running the `docker run` command to create a volume mapping between a directory on the host machine and a directory inside the container. This allows you to persist data outside of the container's filesystem and make it available even if the container is deleted or recreated.
    
2.  **Named Volumes**: You can use the `docker volume create` command to create a named volume, which can be useful when you want to manage the volume independently of the container. Named volumes can be attached to multiple containers and can be backed up, moved, or migrated more easily.
    
3.  **Bind Mounts** : You can use the `-v` flag when running the `docker run` command to create a bind mount between a directory on the host machine and a directory inside the container. This allows you to persist data outside of the container's filesystem and make it available even if the container is deleted or recreated.
    

It's worth noting that, when you map a host directory to a container directory, any changes made to the files inside the container will be reflected on the host directory, and vice versa.

In summary, If you want to persist data inside a container, you can use Docker Volumes, Named Volumes or Bind Mounts, all of them allow you to persist data outside of the container's filesystem and make it available even if the container is deleted or recreated. This way, you can preserve important data and configuration files even if the container is deleted or recreated.

## Difference between ENTRYPOINT and CMD

`ENTRYPOINT` and `CMD` are both used in a Dockerfile to specify the command that should be run when the container starts, but they are used for slightly different purposes:

-   `ENTRYPOINT`: Specifies the command that should be run when the container starts, and it is used to configure the container to run as an executable. The command specified in the `ENTRYPOINT` instruction is always executed, regardless of any command-line arguments passed to the `docker run` command.
    
-   `CMD`: Specifies the command that should be run when the container starts, but it is used to provide default arguments for the `ENTRYPOINT` command. The command specified in the `CMD` instruction can be overridden by command-line arguments passed to the `docker run` command.
    

It's worth noting that, if you specify both an `ENTRYPOINT` and a `CMD` instruction in your Dockerfile, the command specified in the `CMD` instruction will be appended to the command specified in the `ENTRYPOINT` instruction.

For example, if you have an `ENTRYPOINT` instruction of `["/usr/bin/myapp"]` and a `CMD` instruction of `["-d"]`, the container will run the command `/usr/bin/myapp -d` when it starts.

## Docker Compose
A `docker-compose.yml` file is a configuration file that is used to define and run multiple services as part of a single application. The file is written in YAML syntax, which is a human-readable format that is easy to understand and edit.

Here is a general overview of the syntax used in a `docker-compose.yml` file:
```js
version: 'x'
services:
  service_name:
    build:
      context: .
      args:
        arg_name: arg_value
    image: image_name
    command: command_to_run
    ports:
      - "host_port:container_port"
    volumes:
      - "host_path:container_path"
    environment:
      - VAR_NAME=VAR_VALUE
    depends_on:
      - service_name
```
-   The `version` key is used to specify the version of the Compose file format.
    
-   The `services` key is used to define the services that make up the application. Each service is defined as a key-value pair, where the key is the service name and the value is a set of properties that configure the service.
    
-   The `build` key is used to specify the build context and build arguments for a service.
    
-   The `image` key is used to specify the image that the service should use.
    
-   The `command` key is used to specify the command that should be run when the container starts.
    
-   The `ports` key is used to specify the ports that should be exposed by the container.
    
-   The `volumes` key is used to specify the volumes that should be mounted in the container.
    
-   The `environment` key is used to specify the environment variables that should be set in the container.
    
-   The `depends_on` key is used to specify the dependencies between services.
    

This is just a general overview of the syntax used in a `docker-compose.yml` file, and each service can have many more options that can be configured depending on the use case.

It's worth noting that `docker-compose` file version 3 and above have a different syntax, for example, in version 3 and above, the `volumes` instruction is replaced by `volumes` and the `ports` instruction is replaced by `expose`.

* if we would like to instruct Dokcer compose to run a docker build, instead of trying to pull an image, we can replace the image line with a built line and specift the location
`image: [ImageName]` **=>** `build: [FolderPath]`
* the default version of the dokcer-compose file is version 1 to specify the version, you should specify the version at the top of the file `version: [n]`

```js
//docker-compose.yml version1
redis:
	image: redis
db:
	image: postgres:9.4
vote:
	image: voting-app
	ports:
		- 5000:80
	links:
		- redis
```

```js
//docker-compose.yml version2
//you can remove links because docker will create default bridge
//dependencies will be run first
version: 2
redis:
	image: redis
db:
	image: postgres:9.4
vote:
	image: voting-app
	ports:
		- 5000:80
	depends_on:
		- redis
```

```js
//docker-compose.yml version3
//you can remove links because docker will create default bridge
//dependencies will be run first
version: 3
redis:
	image: redis
db:
	image: postgres:9.4
vote:
	image: voting-app
	ports:
		- 5000:80
	depends_on:
		- redis
```

**Example**

```js
//Ref 1:34:32
version: 2
services:
	redis:
		image: redis
		networks:
			- back-end
	db:
		image: postgres:9.4
		networks:
			- back-end
	vote:
		image: voting-app
		networks:
			- front-end
			- back-end
		result:
			image: result
			networks:
				- front-end
				- back-end
	networks:
		front-end:
		back-end:
```

![[Screen Shot 2023-01-14 at 12.57.25 PM.png|500]]

## Docker engine

The Docker Engine is the software that runs on a host machine and is responsible for building, running, and managing Docker containers. It is the core component of the Docker platform and provides all the necessary functionality to work with containers, images, and networks.

The Docker Engine is made up of several different components, including:

-   The Docker daemon: This is the background process that runs on the host machine and manages the containers, images, and networks.

-   The Docker client: This is the command-line tool that allows users to interact with the Docker daemon and perform various operations, such as building images, running containers, and managing networks, it can be remote using `docker -H=address:port`

-   The Docker registry: This is the service that stores and distributes Docker images. The Docker daemon pulls images from the registry and pushes new images to it.

-   The Docker API: This is the interface that allows other applications and services to communicate with the Docker daemon and perform operations on containers, images, and networks.

The Docker Engine can be installed on a wide range of operating systems, including Windows, macOS, and Linux. It can also be run on cloud platforms, such as Amazon Web Services, Microsoft Azure, and Google Cloud Platform.

In summary, The Docker Engine is the core component of the Docker platform, it is responsible for building, running, and managing Docker containers, it consists of several components like the Docker daemon, the Docker client, the Docker registry, and the Docker API. It can be installed on a wide range of operating systems and cloud platforms.

## Namespace in docker

In Docker, namespaces are used to isolate different aspects of a container's environment. A namespace provides a separate and isolated environment for a specific aspect of the container, such as the network, process, or file system.

Docker uses several different namespaces to provide isolation between containers and the host system:

-   The `pid` namespace: Isolates the process ID space, which means that each container has its own set of process IDs, separate from the host system and other containers.
    
-   The `net` namespace: Isolates the network stack, which means that each container has its own network interfaces, IP addresses, and routing tables, separate from the host system and other containers.
    
-   The `ipc` namespace: Isolates the inter-process communication (IPC) resources, which means that each container has its own set of IPC resources, such as semaphores and message queues, separate from the host system and other containers.
    
-   The `mnt` namespace: Isolates the file system namespace, which means that each container has its own set of file systems, separate from the host system and other containers.
    
-   The `user` namespace: Isolates the user and group IDs, which means that each container can have its own set of user and group IDs, separate from the host system and other containers.
    

These namespaces are used by the Docker daemon to create isolated environments for each container, ensuring that the containers are isolated from each other and from the host system, and that each container has its own set of resources, such as process IDs, network interfaces, and file systems.

In summary, Namespaces in Docker are used to isolate different aspects of a container's environment, Docker uses several different namespaces such as pid, net, ipc, mnt and user to provide isolation between containers and the host system, and to ensure that each container has its own set of resources, and that the containers are isolated from each other and from the host system.

## Docker cgroups

Docker containers can consume as mush resources (memory, cpu, i/o, ..) as they can.
In Docker, cgroups (short for control groups) are used to limit and control the resources that a container can use. A cgroup is a Linux kernel feature that allows you to allocate resources such as CPU, memory, and I/O bandwidth to a group of processes.

Docker uses cgroups to control the resources that a container can use, including:

-   CPU: You can limit the amount of CPU time that a container can use, and also specify how the CPU time should be shared between multiple containers.
    
-   Memory: You can limit the amount of memory that a container can use, and also specify how the memory should be allocated between multiple containers.
    
-   I/O: You can limit the amount of I/O bandwidth that a container can use, and also specify the priority of the container's I/O operations.
    
-   Network: You can limit the amount of network bandwidth that a container can use, and also specify how the network bandwidth should be shared between multiple containers.
    

Cgroups can be used to ensure that a container does not consume more resources than it needs, and also to ensure that multiple containers share resources fairly.

It's worth noting that cgroups can be used in conjunction with namespaces to provide a more complete isolation and resource allocation solution.

In summary, Cgroups (Control Groups) in Docker are used to limit and control the resources that a container can use, including CPU, memory, I/O, and Network bandwidth, it allows to ensure that a container does not consume more resources than it needs, and also to ensure that multiple containers share resources fairly, it can be used in conjunction with namespaces to provide a more complete isolation and resource allocation solution.

## Docker orchestration

Docker orchestration is the process of managing and coordinating the deployment, scaling, and operation of multiple Docker containers across multiple hosts. It allows you to automate the process of creating, updating, and scaling your containerized applications.

Docker provides several tools for orchestration, including:

-   **Docker Compose**: is a tool for defining and running multi-container applications. It allows you to define the services that make up your application in a single `docker-compose.yml` file, and then use the `docker-compose` command to start, stop, and manage those services.
    
-   **Docker Swarm**: is a native orchestration tool that allows you to create and manage a swarm of Docker engines, and then deploy services to the swarm. It provides features such as service discovery, load balancing, and scaling.
    
-   **Kubernetes**: is an open-source container orchestration system that provides features such as automatic scaling, self-healing, and rolling updates. Kubernetes is a popular choice for organizations running large-scale production workloads, and it can be used to manage both Docker and non-Docker workloads.
    
-   **Mesos**: is another open-source container orchestration system that is similar to Kubernetes. It provides features such as automatic scaling, self-healing, and rolling updates.

In summary, Docker orchestration is the process of managing and coordinating the deployment, scaling, and operation of multiple Docker containers across multiple hosts, Docker provides several tools for orchestration such as *Docker Compose*, *Docker Swarm*, *Kubernetes*, and *Mesos*, These tools provide a way to automate the process of creating, updating, and scaling containerized applications, and can be used to manage large

## Kubernetes

Kubernetes (often abbreviated as "k8s") is an open-source container orchestration system that provides features such as automatic scaling, self-healing, and rolling updates. It was developed by Google and is now maintained by the Cloud Native Computing Foundation (CNCF).

Kubernetes allows you to deploy, scale, and manage containerized applications in a cluster of machines. It provides a set of abstractions for defining, deploying, and managing containerized applications, including:

-   Pods: the smallest and simplest unit in the Kubernetes object model, that represents a single process or container running on a node.
    
-   Services: a way to expose a set of Pods to the network and load balance traffic between them.
    
-   Replication Controllers: ensures that a specified number of replicas of a Pod are running at any given time.
    
-   Deployments: is a higher-level concept that allows you to declaratively manage Replication Controllers and Pods.
    
-   StatefulSets: is used to manage stateful applications, it provides guarantees about the ordering and uniqueness of pods
    
-   ConfigMap and Secrets: are used to manage configuration data and secrets separately from the application code.
    
-   Ingress: allows external users to access services running in a cluster.
    

Kubernetes provides an API for interacting with the cluster, which allows you to create, update, and delete objects, as well as query the current state of the cluster. It also provides a command-line tool called `kubectl` for interacting with the API.

Kubernetes is a popular choice for organizations running large-scale production workloads and is supported by major cloud providers, it can be used to manage both Docker and non-Docker workloads.

In summary, Kubernetes is an open-source container orchestration system that provides features such as automatic scaling, self-healing, and rolling updates, it was developed by Google and is now maintained by the Cloud Native Computing Foundation (CNCF). It provides a set of abstractions such as Pods, Services, Replication Controllers

# Notes
* Container are not meant to host an operating system, Container meants to run a specifc task
* while the task is running the container will still exist, it will exit only when a task is complete or it crahses.
* https://kodekloud.com/lessons/hands-on-labs/
*  docker compose example [1h26](https://www.youtube.com/watch?v=fqMOX6JJhGo&t=1402s)
* image: `[regestry]/[userAccount]/[imageName]`
* windows 10 professional and enterprise (Hyper-V Isolated Containers)
* there is windows containers and linux containers
* docker toolBax vs docker desktop