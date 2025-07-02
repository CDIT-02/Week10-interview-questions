Pods
    Multi-container pods
    1. How many containers can be run in a pod? How do you Login to a container in a pod?
        kubectl exec -n <ns> -it pod-name /bin/bash
        kubectl exec -it my-pod -c nginx-container -- /bin/sh
        kubectl exec -it my-pod -c helper-container -- /bin/sh


        kubectl exec my-pod -c nginx -- ls /var/www/html/
        
    2. Init container?
            Init Containers are containers that are part of a pod. They start and run to completion before the main containers in the pod begin.
            They serve as a preparatory step, allowing us to carry out initialization tasks, set up prerequisites, or configure dependencies needed by the application in the main containers.
            If the Pod is restarted, all its init containers will run again.
            Do not support the lifecycle, livenessProbe, readinessProbe, and startupProbe fields.
            eg:

        To see logs for the init containers in this Pod, run:
        kubectl logs myapp-pod -c init-myservice # Inspect the first init container
        kubectl logs myapp-pod -c init-mydb      # Inspect the second init container


    3. Sidecars containers?
        A sidecar container in Kubernetes is like a motorcycle's sidecar, running alongside the main container to add features without changing the main app like fluentd or logstash
            eg: Check sidecar-container

    4. How do you allocate resources for a pod?

    5. What is livenessProbe, readinessProbe, and startupProbe
        livenessProbe: healthcheck in asg, Checks if a container is still running.
        readinessProbe: Ensures app only gets traffic when ready
        startupProbe: Checks if a container has successfully started.
        check pod.yaml file

Pod Storage:
    emptyDir - Bound to a pod
    hostPath - Bound to a Node
    persistentVolumes - EBS, EFS, Object storage
    PersistentVolumeClaims
    StorageClass 


    Static pods 
    1.  What is a static pod? Main use?
            A static pod is a special type of pod that is not managed by the Kubernetes control plane like other pods. Instead, it is created and managed directly by a Kubelet.
            It is primarily used for cluster bootstrapping purposes like starting the cluster components like the API server, controller manager, scheduler etc.
    2.  How to create a Static pod?
            cd /etc/kubernetes/manifests
                ├── etcd.yaml
                ├── kube-apiserver.yaml
                ├── kube-controller-manager.yaml
                └── kube-scheduler.yaml

What are the below ?
Difference betweeen the below ?
Use cases of the below ?         
ReplicaSets: Stateless, autoscaling, Selfhealing : webservers
StatefulSets: Stateful, stable network identity, persistent storage : DBs
DaemonSets: Prom node exporter, node specific tasks, log cleaner pod

ReplicaSets are great for stateless applications that require high availability and horizontal scaling.
StatefulSets are ideal for stateful applications where stable network identities, ordered deployment, and persistent storage are needed.
DaemonSets are best for system-level applications that need to run on every node, such as monitoring, logging, or network management tools.



Difference between Replicaset and Deployments
    Replicaset: Auto scaling, self healing, rescheduling
    Deployments: Declarative Updates, Rolling Updates and Rollbacks, Strategy Configuration, Scalability

ReplicaSets focus on maintaining a set number of pod replicas, ensuring high availability and self-healing of pods. They are more primitive and do not provide built-in features for updates or rollbacks.
Deployments are more advanced and manage ReplicaSets. They add features like rolling updates, rollbacks, pause/resume functionality, and version control, making them the preferred method for deploying and managing stateless applications.

Deployments:
    Deployments strategies
        Rolling update(default)
        Recreate
    How to rollback to a specific version? 
        kubectl rollout history deployment/nginx-deployment
        kubectl rollout undo deployment/nginx-deployment --to-revision=2
    What other deployment strategies you know ? 
        blue green
        canary
        A/B testing

Difference between configMap and secrets?

Services:
    ClusterIP
    Nodeport
    Load balancer - Exposes a single service externally	, Directly forwards to one service
    Ingress - Exposes multiple services with routing rules, Routes based on URL path, hostname, etc.

LoadBalancer is best when you need quick, direct access to a single service and have simple networking requirements.
Ingress is more suitable when you need to manage traffic for multiple services, especially if you require custom routing rules, SSL termination, or if you want to avoid creating multiple load balancers.


General Questions:-
==================

1. What are taints and tolerations in Kubernetes, and when would you use them?
    Taints - Marks on nodes
    Tolerations - Specified in Pod manifest to place a pod in tainted nodes

2. Explain the concept of a StatefulSet and give an example use case.

3. Explain the concept of a DaemonSet and give an example use case.

4. Describe the differences between Ingress and LoadBalancer in Kubernetes.


Cluster Architecture & setup:
    1. Explain the main components of a Kubernetes control plane and their roles.
        API Server: Exposes the Kubernetes API, which is the entry point for administrative commands.
        etcd: A distributed key-value store that holds all cluster data.
        Controller Manager: Manages controllers that handle routine tasks, like maintaining node states, job completion, and replication.
        Scheduler: Decides where to place new Pods based on resource availability and scheduling policies.

    2. What is the role of the kubelet in a Kubernetes cluster, and how does it interact with the control plane?
        The kubelet is an agent that runs on each worker node. It listens to the API Server for instructions and ensures that the containers described in a PodSpec are running and healthy. The kubelet also reports the status of the node and the Pods back to the control plane.

    3. How does a Kubernetes cluster handle high availability of the control plane?
        High availability of the control plane is achieved by:
            Deploying multiple instances of the API Server, etcd, Controller Manager, and Scheduler across different nodes.
            Using a load balancer to distribute traffic among multiple API Server instances.
            Running etcd in a distributed mode to ensure data redundancy.
            Eg: EKS or GKE Managed services, On prem cluster - Setup highly available etcd cluster and multiple API servers
    
    4. Your organization is planning to migrate a monolithic application to a Kubernetes-based microservices architecture. What architectural considerations would you address?
        Break down the monolith into smaller, independently deployable services.
        Design a service discovery mechanism and inter-service communication using Kubernetes services.
        Implement observability (logging, metrics, tracing) to monitor microservices.
        Define resource requests/limits for each microservice to optimize resource usage.

        


Cluster configuration
    1. What is CoreDNS in Kubernetes, and how can you configure it for custom domain resolution?
    2. How does the kubeconfig file facilitate communication with a Kubernetes cluster, and what are its key components?

Cluster upgrade
    1. Describe the order in which Kubernetes components should be upgraded and why.
        Control Plane Components: Begin with etcd, followed by the API Server, Controller Manager, and Scheduler.
        Worker Nodes: Upgrade the kubelet and kube-proxy on each node.
        kubectl: Finally, update kubectl on client machines.

    2. What are the common approaches to upgrading a Kubernetes cluster, and what are the trade-offs?
        In-place Upgrade: Directly updating the Kubernetes components on existing nodes. This is simpler but may introduce downtime or compatibility issues if not done correctly.
        Blue-Green Upgrade: Setting up a parallel cluster (green) while the old one (blue) continues to run. You then migrate workloads gradually. This approach minimizes downtime but is more resource-intensive.

    3. How would you handle a Kubernetes cluster upgrade if you encounter compatibility issues with a specific node?
         If a node fails during the upgrade due to compatibility issues:
            Roll back the upgrade for that specific node by downgrading kubelet and kube-proxy.
            Check for version-specific compatibility documentation and update configurations accordingly.
            Quarantine the node if possible, and test the upgrade in a staging environment to identify the issue.

    4. How would you roll back a failed Kubernetes upgrade on a worker node?
        Revert the kubelet and kube-proxy binaries to the previous version.
        Restart the kubelet and kube-proxy services to apply the changes.
        Rejoin the node to the cluster if it was removed.


Jobs and CronJobs:
    Jobs: When pod completes it work, exit. 
    cronJobs: Run the same pod at regular interval


Taints and Tolerations:

Security:
Service Accounts

RBAC

Roles and clusterRoles




