### What is kubernetes

Kubernetes (often abbreviated as K8s) is an open-source container orchestration platform developed by Google. It automates the deployment, scaling, and management of containerized applications. With Kubernetes, you can easily deploy and manage applications across a cluster of machines. It provides features for container scheduling, automatic scaling, self-healing, service discovery, load balancing, and rolling updates.

It allows you to define your application's desired state through YAML or JSON files called manifests, which describe how your application should run, including details such as the number of replicas, networking, storage, and resource requirements.

- open-source container orchestration platform developed by Google
- It automates the deployment, scaling and management of containerized application
- It allows you to define your application's desired state through YAML or JSON 
- It provides many features such as automatic scaling, self-healing, lead balancing ...


### The need of container orchestration 

- Scaling
- Self-healing
- Resource optimization
- Load balancing
- Declarative configuration
- Rolling update and rollbacks
- High availability
- Disaster recovery

### Kubernetes components

- Volume 
- Pod
- Service
- Ingree
- ConfigMap
- Secrets
- Deployment
- Statefulset

##### Notes

- A **node** can be either a physical machine or a virtual machine.
    
- Each **node** can host multiple pods.
    
- Each **pod** has its own IP address for communication with other pods.
    
- A **pod** can contain multiple containers.
    
- Container creation is abstracted due to the variety of technologies available.
    
- **Pods** receive new IP addresses upon recreation.
    
- A **service** has a permanent IP address.
    
- **Service** can manage multiple pods.
    
- **Service** can run multiple replicas of the same application.
    
- **Service** acts as a load balancer, routing requests to the least busy replica.
    
- The lifecycles of pods and services are independent.
    
- There are external and internal services.
    
- To access a service, one must use its IP address, typically in the form of _node_address:port_of_the_service_.
    
- **Ingress** handles requests received as domain names and forwards them to services.
    
- **ConfigMap** provides external configuration for applications, facilitating configuration changes.
    
- **Secret** functions similarly to ConfigMap but for handling sensitive data.
    
- **Volume** attaches physical storage to pods for data persistence.
    
- **Deployment** serves as a blueprint for pods, allowing specification of the desired number of replicas.
    
- **Deployment** is also an abstraction of pods.
    
- **StatefulSet** is used for stateful applications or databases.
    
- Databases are often hosted outside of the Kubernetes cluster.


**Pod:** The fundamental unit of deployment in Kubernetes. Encapsulating one or more containers with shared storage and network resources, a Pod represents a single instance of an application running on your cluster.
**Service:** Exposes a set of Pods as a single unit to the external world. Think of it as a traffic director that routes incoming requests to the appropriate Pods in your application. Services abstract details like individual Pod IP addresses, making it easier to manage your application.
**Ingress:** (Not directly a Kubernetes resource, but works with it) An external facing HTTP(S) load balancer for routing traffic to Services within your Kubernetes cluster. Imagine a front door for your application that sits outside the cluster, directing users to the Service behind it.

**ConfigMap:** Stores configuration data for your application in a key-value pair format. This is a great way to manage application settings without hardcoding them in your container image. Think of it like an external configuration file that Pods can access.
**Secrets:** Similar to ConfigMaps, but specifically designed to store sensitive data like passwords, API keys, or tokens. Secrets are secured within the Kubernetes cluster and not intended to be shared publicly.


**Volume:** A way to provide persistent storage for a Pod. Volumes can be physical disks, cloud storage, or even other persistent resources.


**Deployment:** A Deployment is a Kubernetes resource used to manage the lifecycle of replicated pods. It defines a desired state for a set of pods, ensuring that a specified number of replicas are running and automatically handling scaling, rolling updates, and rollbacks.

**StatefulSet:** A StatefulSet is a Kubernetes resource designed for managing stateful applications that require stable, unique network identifiers, persistent storage, and ordered deployment and scaling.


### Kubernetes architecture

Kubernetes architecture revolves around two main components working together to manage containerized applications: the *control plane* and the *data plane*.

#### Control Plane

The control plane's components make global decisions about the cluster (for example, scheduling), as well as detecting and responding to cluster events (for example, starting up a new pod when a Deployment's replicas field is unsatisfied).

**kube-apiserver** The API server is a component of the Kubernetes [control plane](https://kubernetes.io/docs/reference/glossary/?all=true#term-control-plane) that exposes the Kubernetes API. The API server is the front end for the Kubernetes control plane.

	
![[kubernetes-cluster-architecture.svg]]

![[full-kubernetes-model-architecture-137469657.png]]

![[DIAGRAM_White-Paper_Reducing-container-costs-with-Kubernetes_7_14jul20_Tetris-game-autoscaling-e1600862694346.png]]

**etcd:** Consistent and highly-available key value store used as Kubernetes' backing store for all cluster data.
If your Kubernetes cluster uses etcd as its backing store, make sure you have a back up plan for the data.

**kube-scheduler:** The scheduler is responsible for placing pods onto nodes in the cluster based on resource requirements, affinity/anti-affinity rules, and other constraints. It ensures that pods are efficiently distributed across the cluster.

**kube-controller-manager:** The controller manager is a collection of controllers responsible for maintaining the desired state of the cluster. Each controller watches the state of specific Kubernetes objects (e.g., pods, replica sets, services) through the API server and takes corrective action to ensure that the actual state matches the desired state.

**cloud-controller-manager:** A Kubernetes [control plane](https://kubernetes.io/docs/reference/glossary/?all=true#term-control-plane) component that embeds cloud-specific control logic. The [cloud controller manager](https://kubernetes.io/docs/concepts/architecture/cloud-controller/) lets you link your cluster into your cloud provider's API, and separates out the components that interact with that cloud platform from components that only interact with your cluster.

#### Node Components (Data Plane)

The node components in Kubernetes are responsible for managing the containers and providing the necessary runtime environment for running the pods. Each node in a Kubernetes cluster typically consists of the following components

- **Kubelet**:
    
    - The kubelet is an agent that runs on each node in the cluster and is responsible for managing the containers running on that node. It receives pod specifications from the Kubernetes API server and ensures that the containers described in those specifications are running and healthy on the node. The kubelet also monitors the health of the containers and reports back to the master node.
- **Container Runtime**:
    
    - Kubernetes supports various container runtimes, such as Docker, containerd, and CRI-O. The container runtime is responsible for running and managing containers on each node in the cluster. It pulls container images from container registries, creates container instances, manages container lifecycles (e.g., starting, stopping, restarting), and handles resource isolation and management.
- **Kube-proxy**:
    
    - Kube-proxy is a network proxy that runs on each node and facilitates network communication to and from the pods. It maintains network rules and performs connection forwarding, load balancing, and service discovery to enable communication between pods and external clients. Kube-proxy ensures that networking features such as service discovery and load balancing are implemented consistently across the cluster.