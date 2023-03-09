Docker provides several networking options for connecting containers to each other and to the outside world. The main networking types in Docker are:

1.  `Bridge network`: The bridge network is the default networking type in Docker. It allows containers to communicate with each other on the same host, using IP addresses assigned by the Docker daemon. Each container on the bridge network is assigned a unique IP address, and can communicate with other containers on the same network using that IP address.
2. `Host network`: The host network allows a container to share the host's network stack, using the same IP address as the host. This means that the container can access the same network interfaces and ports as the host, without any port mapping or network address translation (NAT).
3. `Macvlan network`: The Macvlan network allows containers to be directly connected to the physical network, using a virtual MAC address and IP address that are unique to the container. This allows containers to be directly accessible from the physical network, and can be useful for applications that require direct network access.
4. `None network`: The none network disables networking entirely for a container, meaning that it cannot connect to any other container or the outside world. This can be useful for running containers that do not require network access, or for testing purposes.
5. `Overlay network`: The overlay network allows containers to communicate with each other across multiple hosts, using a virtual network overlay that spans multiple physical networks. This is useful for scaling out containerized applications across multiple hosts, while maintaining a single logical network.

- To create a network of any of the above types in Docker, you can use the `docker network`

```c
//User Define Bridge
docker network create mybridge
//MacVlan
docker network create -d macvlan \
	--subnet 10.7.1.0/24 \
	--gateway 10.7.1.3 \
	-o parent=enp0s3 \
	nameOfTheNetwork
```

![[Screen Shot 2023-03-04 at 4.50.12 PM.png]]
https://www.youtube.com/watch?v=bKFMS5C4CG0&t=1593s

## Notes

- the `Macvlan network` Need the `Promiscuous` mode to be enable.
- the `user define bridge` allow you to `ping` by name
- ![[Debian#Network]]