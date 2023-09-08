# Microservices Basic Lab

Mission: Make two microservices, make them communicate privately and open up one for host access (http://localhost:5002)

## Using Minikube to Deploy Microservices

### Prerequisites

Before you begin, ensure you have the following installed on your system:

1. [Docker](https://docs.docker.com/get-docker/)
2. [Minikube](https://minikube.sigs.k8s.io/docs/start/)
3. [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### Step 1: Install and Start Minikube

1. Install Minikube by following the official documentation for your operating system.

2. Start Minikube by running the following command:
   ```bash
   minikube start
   ```

This command will create a new Minikube cluster.

### Step 2: Point Minikube to Docker Environment

To use Minikube's built-in Docker daemon, execute the following command:

```bash
eval $(minikube docker-env)
```

This command configures your shell to use the Docker daemon inside Minikube's virtual machine, allowing you to build Docker images that will be available to your Minikube cluster.

### Step 3: Create Docker Images

Assuming you have your microservices code and Dockerfiles ready, you can now build Docker images for your microservices. Navigate to your microservice project directories and run the following commands for each microservice:

```bash
docker build -t microservice1:1.0.0 .
```
```bash
docker build -t microservice2:1.0.0 .
```

### Step 4: Deploy Microservices with Kubernetes

Now that you have Docker images for your microservices, you can create Kubernetes deployments and services for them.

1. Create a Kubernetes deployment YAML file for each microservice. Example YAML:

   ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
    name: serviceX-deployment
    labels:
        app: serviceX
    spec:
    replicas: 3
    selector:
        matchLabels:
        app: serviceX
    template:
        metadata:
        labels:
            app: serviceX
        spec:
        containers:
            - name: serviceX
            imagePullPolicy: Never
            image: microserviceX:1.0.0
            ports:
                - containerPort: <port>
   ```

2. Apply the deployment to your Minikube cluster using `kubectl`:

   ```bash
   kubectl apply -f <microservice-deployment.yaml>
   ```

   Repeat this step for each microservice.

3. Create a Kubernetes service YAML file for each microservice. Example YAML:

   ```yaml
    apiVersion: v1
    kind: Service
    metadata:
    name: serviceX-service
    spec:
    selector:
        app: serviceX
    ports:
        - port: <port>
        targetPort: <port>
   ```

   Replace `<microservice-name>` with your microservice's name.

4. Apply the service to your Minikube cluster using `kubectl`:

   ```bash
   kubectl apply -f <microservice-service.yaml>
   ```

   Repeat this step for each microservice.

### Step 5: Accessing Microservices

To access your microservices, you can use Minikube's built-in service:

```bash
minikube service <microservice-name>-service
```

This will open a browser or terminal window with the URL to your microservice.

Remember to clean up your resources when you're done:

```bash
minikube stop
minikube delete
```