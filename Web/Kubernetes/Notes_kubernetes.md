**node** can be a physical machine or virtual machine
**node** can have many pods
each **pod** has his own IP address to communicate with other pods
the **pod** can have many containers
abstruct the container creation because their is many technologies to create containers 
**pods** get new IP addresses on re-creation

**service** has permanent IP address
**service** can have many pods
**service** can have many replica running the same application
**service** is also a load balancer that get the request and forward it to the replica that is less busy 

the lifecycle of pods and service are independent 
there is external service and internal service 
to access the service you have to use it IP address which in the form of *node_address:port_of_the_service*
**Ingress** get the request as a domain name than forward it to service IP address
**configMap** it's an external configuration for the application to facilitate the change of the configuration
**secret** it's like configMap but for secret data.
**volume** attaches a physical storage to the pod to persists data.

**Deployment** is a blueprint for pods we can specify how many replica that we need
**Deployment** is also an abstraction of pods
**StatefulSet** for stateful apps or databases
DB are often hosted outside of K8s cluster



**Worker Node**
each node must have 3 processes installed
worker nodes do the actual work

- kubelet: interact with both container and node, it is also responsible of starting the pod with a container inside
- kube-proxy: make sure to make intelligent request forwarding with lower overhead 
- container-runtime: such as docker it's responsible for running and managing containers 


**Master Node**

- it has different processes than worker node
- it control the work nodes

- Api-server: it act like cluster geteway and also act as getekeeper for authentication 
- scheduler: Where to put the Pod, it decides on which node new pod should be schedule, it just decide the process the do the scheduling of the pod is the kubelet inside the node
- controller manager: detects cluster state changes, and recover the node by re-scheduler dead pods
- etcd: key value store for the cluster, it provide the master with cluster state, the available resources and the health of the cluster
	- etcd does not store the application data



in the production there will be multiple master and multiple worker 

minikube where the master processes and worker processes are run on the same machine

- creates virual box and run nodes on it

kubctl : is a command line tools for kubernets claster that communicate with API server

```sh 

#start minikube
minikube start --vm-driver=virtualbox

#get nodes
minikube status

#get nodes
kubectl nodes

#check pods
kubectl get pod
kubectl get pod -o wide

#ckeck services
kubectl get services

#get deployment
kubectl get deployment

#get replicaset
kubectl get replicaset

#get ingress
kubectl get ingress

#create deployement
kubectl create deployment [NAME] --image=image ...

#edit deployment
kubectl edit deployement [NAME]

#get deployment
kubectl get deployment [NAME] -o yaml

#get info about pod
kubectl describe pod [NAME]

#get info about service
kubectl describe service [NAME]

#get pod logs
kubectl logs [pod_name]

#get interactive terminal of a pod
kubectl exec -it [pod_name] -- bin/bash

#delete deployment
kubectl delete deployment [deployment_name]

#apply a configuration file
kubectl apply -f [config-file.yaml]

#delete a configuration file
kubectl delete -f [config-file.yaml]

#get namespace
kubectl get ns

#get all component in kubernets 
kubectl get all -n [namespace]

#get endpoints
kubectl get endpoints


```

- nginx-deployment.yaml
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
	  app: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80

```

![[Screenshot from 2024-03-15 21-16-20.png]]

----


## YAML configuration file in kubernetes

Each configuration file has 3 parts:
- metadata
- specification
	- template
		- has his own metadata and spec
- status

```
apiVersion: apps/v1
kind: Deployment
metadata:
spec:
```

attributes of 'spec' are specific to the kind
Pods get the `label` through the template blueprint, this label is match by the selector
to `connect` a service with a pod deployment we specify the pod label in the `selector section`  in the service configuration file.

A service configuration file:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80 #service port
      targetPort: 80 #port of the pod

```
![[Screenshot from 2024-03-18 10-53-45.png]]

- to make sure that the service has the right pods
	- `kubectl describe service [service_name]`
	- the endpoint attribute should has the ip addresses of the pods
	- `kubectl get pod -o wide`
	- 

![[Screenshot from 2024-03-18 13-55-12.png]]


---
- Namespace : is a virtual cluster inside cluster
- 
In Kubernetes, namespaces are a way to create virtual clusters within a physical cluster. They provide a scope for Kubernetes objects, such as pods, services, deployments, and secrets. Namespaces help organize and partition resources within a cluster, making it easier to manage and isolate different workloads and applications.

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: my-namespace

```

```bash
kubectl create namespace my-namespace
```

- use of namespace:
	- resources grouped in namespaces (namespace for db, namespace for nginx...)
	- if you have different application with the same name
	- limit access and resources for a namespace

![[Screenshot from 2024-03-18 20-56-43.png]]

- can't access configuration file from different namespaces
- there some component that can't be put inside namespace like Vol, Node

- you can add a service or deployment in a namespace using
	- kubectl command
	- inside the yaml file in the metadata section 
	- when you use kubectl get or any related command you have to add namespace flag, otherwise the default namespace will be used
- to switch between active namespaces, install `kubectx` to use `kubens`


#### Ingress

- ingress will get the external request coming from the browser and forward it the internal service 

![[Screenshot from 2024-03-22 12-00-29.png]]


- to configure ingress you need an ingress implementation which is `ingress controller` which is a pod or a set pods that evaluate and processes ingress rules
	- evaluate all the rules
	- manages redirection
	- entry point to cluster 
	- many third party implementation
	- K8s Nginx ingress controller
![[Screenshot from 2024-03-22 12-14-02.png]]

- Steps  for minikube
	- install ingress controller
	- `minikube addons enable ingress` to check you can use `kubectl get pod -n kube-system`
	- create ingress rule
	- `kubectl get ingress`
	- modify `/etc/hosts`
	- `kubectl describe ingress [ingress_name] -n [name_space]`
	- you can define multiple path for each service
	- you can define multiple host for each service
	- you can configure TLS for certificate for https

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: dashboard-ingress
  namespace: kubernetes-dashboard
  annotations:
    kubernetes.io/ingress.class: "nginx"
spec:
  rules:
  - host: dashboard.com
    http:
      paths:
      - path: /
        pathType: Exact  
        backend:
          service:
            name: kubernetes-dashboard
            port: 
              number: 80
```

- multiple path, multiple host
![[Screenshot from 2024-03-22 12-40-48.png]]

- TLS
![[Screenshot from 2024-03-22 12-45-34.png]]

#### Helm-Package Manager of `K8s`

- `Helm` is a package manager for `K8s` it distributes `YAML` files in public and private repositories
- `Helm charts` is a bundle of `YAML` files, 
- `Templating engine` is a template that define values in one place for the `YAML` configuration it helps to avoid to define the same configuration for the `YAML` files multiple times for different services that share the same parameters
	- values defined via `YAML` file or with `--set` flag

![[Screenshot from 2024-03-22 13-01-06.png]]

![[Screenshot from 2024-03-22 13-01-22.png]]
- `Helm` structure
![[Screenshot from 2024-03-22 13-06-13.png]]

```bash
heml install <chartname>
heml install --values=[custom_values_file.yaml] <chartname>
	it will override values inside values.yaml
helm install --set name=value <chartname>
```

- `helm` store configuration file for future reference, for (upgrade, rollback or other commands)

```bash
helm install <chartname>
heml upgrade <chartname>
helm rollback <chartname>
```

- There is `helm` version 2 and 3
	- version 2 : the `helm` `CLI` send the request to `tiller` server inside kubernetes cluster to deploy the chart
	- version 3 : because tiller server has many permission like install delete and upgrade deployments it make less secure, in version 3 `tiller server` is removed 


#### K8s Volumes 

`Persistent volume`, `Persistent volume claim`, `Storage class`
`PV`,  `PVC`, `SC`

Persistent Volumes (PVs) in Kubernetes provide a way for users to manage durable storage in a cluster. They abstract the details of how storage is provisioned and managed from the underlying infrastructure, allowing for more flexible and portable storage solutions.
- PVs have a lifecycle independent of any individual pod or workload
- they are not tied to any namespace
- Administrators can define multiple Storage Classes, each corresponding to a different type of storage backend (e.g., SSD, HDD, cloud storage). Users can then request PVs with specific Storage Classes to suit their application's needs.
- PVs support different access modes, such as ReadWriteOnce (RWX), ReadOnlyMany (ROX), and ReadWriteMany (RWX), allowing multiple pods to access the same volume simultaneously or restrict access to a single pod.
- Kubernetes supports various volume plugins, including cloud providers (such as AWS EBS, Azure Disk), networked filesystems (such as NFS, GlusterFS), and local storage options. These plugins enable Kubernetes to work with a wide range of storage backends.

- K8s admin vs K8s user
	- admin setup and maintain the cluster
	- user deploys applications in cluster


- `A Persistent Volume Claim (PVC)` in `Kubernetes` is a request for storage by a user or a group of users. It allows users to claim a portion of storage defined by Persistent Volumes (`PVs`) without having to know the underlying storage details.
	- PVCs support dynamic resizing, allowing users to resize storage volumes as needed
	- Users can abstract storage details from their applications by using PVCs.
	- Users can manage storage resources effectively by defining resource quotas and limits for PVCs.


- `ConfigMap` and `Secret` are located in local volume and manage by `kubernetes`, they are not created via `PV` and `PVC`

- Pod with configured volume
![[Screenshot from 2024-03-22 16-25-35.png]]

- app with configMap, secretMap and PVC
![[Screenshot from 2024-03-22 16-27-45.png]]


- `Storage class` A StorageClass in Kubernetes is an object that defines the properties and parameters for dynamically provisioning PersistentVolumes (PVs). It enables users to request storage without having to manually provision it
	- - StorageClasses enable dynamic provisioning of PVs, allowing users to request storage on-demand. When a PersistentVolumeClaim (PVC) is created, Kubernetes automatically provisions a PV that matches the requirements specified in the PVC and the associated StorageClass.
	- Dynamic provisioning eliminates the need for administrators to pre-provision storage volumes, making storage management more efficient and scalable.
	- Allows defining performance and availability requirements.

- define a storageClass
![[Screenshot from 2024-03-22 16-55-29.png]]

- define a PVC that benefit from StorageClass
![[Screenshot from 2024-03-22 16-56-43.png]]
- global view: when the pod need persisted storage it calls PVC, than the SC will create a suitable PC for the job.
![[Screenshot from 2024-03-22 16-58-32.png]]


#### `StatefulSet`

- A StatefulSet in Kubernetes is a resource type designed for managing stateful applications, such as databases or other distributed systems. It provides unique identity, stable network identifiers, and persistent storage for each pod.
- all application that have state and store data like databases
- while `stateless` application deployed using `deployment`, `stateful` application are deployed using `statefulset` 


- **Stateful Pods**: One pod is designated as the master, allowed to update data, while others, called slaves or workers, are only permitted to read data.
- Each pod uses its own physical storage, necessitating a synchronization mechanism between the master and workers.
- When a worker joins or is newly created, it initially clones data from previously created databases before becoming operational.
- Upon pod termination, associated data is deleted along with it; thus, it's advisable to create PersistentVolumes (PVs) for data persistence.
- Each pod possesses a unique identity, which it retains upon recreation.
- The creation of the next pod is contingent upon the successful operation of the preceding one.
- Each pod is assigned its own DNS name.
- Pod restarts result in IP address changes, yet the endpoint and role remain consistent.

#### Kubernetes Services

- `ClusterIP Services`, `Headless Services`, `NodePort Services`, `Loadbalancer Services`

- the pod ip address is change when the pod is restart
- service has stable IP address 
	- loadbalancing
- there is sveral types of kuberbetes service

##### ClusterIP service

- default type of a service
- how it's work
- pods are identified to the service via selector section
- for selecting the target port of pods, we have to specify `targetPort` in ports section
- `kubectl get endpoints` command to get service endpoints 
![[Screenshot from 2024-03-26 15-10-36.png]]

- to allow a service to forward for multiple ports you have to provide name for each port
![[Screenshot from 2024-03-26 15-10-36 1.png]]

##### `Headless Service`

- A `Headless Service` is a service that does not allocate an IP address to a Kubernetes service. Instead, it is used for discovering endpoints of other services through DNS lookups. When you create a Headless Service.
	
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-headless-service
spec:
  clusterIP: None
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
```

With a Headless Service, DNS resolution is used to discover individual pods backing a service. Each pod gets its DNS A record, which resolves to the pod's IP address. This enables direct communication with individual pods without going through a load balancer.

Kubernetes does not assign a ClusterIP to it.
	- Client want to communicate with one pod directly
	- Pod want to communicate directly with another pod
	- example: Stateful application

```bash
nslookup my-headless-service.default.svc.cluster.local
```

This should return the IP addresses of all pods associated with the Headless Service.


##### `NodePort Services`

In Kubernetes, a NodePort Service is a way to expose a service externally, outside of the Kubernetes cluster. It opens a specific port on all nodes (or a specified set of nodes) and forwards traffic from that port to the service.

- Specify the node port (range: 30000-32767)

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-nodeport-service
spec:
  type: NodePort
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
      nodePort: 30000 

```

- directly exposing services using NodePort may not be suitable for production environments, as it exposes services on every node and relies on the node's IP address
- NodePort services are commonly used when you need to expose your application externally, but you don't want to use a LoadBalancer service

![[Screenshot from 2024-03-26 15-40-12.png]]

##### `LoadBalancer`

In Kubernetes, a LoadBalancer service type is used to expose your service outside of the Kubernetes cluster by provisioning a cloud provider's load balancer. The load balancer distributes incoming traffic to the nodes running your service.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-loadbalancer-service
spec:
  type: LoadBalancer
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
```

![[Screenshot from 2024-03-26 15-45-25.png]]