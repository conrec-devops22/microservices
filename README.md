# Microservices Basic Lab

Mission: Make two microservices, make them communicate privately and open up one for host access (http://localhost:5002)

## Using Minikube to Deploy Microservices

### Prerequisites

Before you begin, ensure you have the following installed on your system:

1. [Docker](https://docs.docker.com/get-docker/)
2. [Minikube](https://minikube.sigs.k8s.io/docs/start/)
3. [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

# Deploy to Minikube GitHub Actions Workflow

This GitHub Actions workflow automates the deployment of microservices to a Minikube Kubernetes cluster. It assumes that you have set up a Minikube cluster and that your Kubernetes service is of type NodePort.

## Workflow Steps

### Step 1: Checkout Code
- This step checks out your code repository so that subsequent steps can access your project files.

### Step 2: Start Minikube
- This step sets up Minikube using the Docker driver and waits for all components to be ready.

### Step 3: Try the Cluster
- This step verifies the Minikube cluster by listing pods in all namespaces.

### Step 4: Setup Docker Environment
- This step configures the Docker environment to use Minikube's Docker daemon.

### Step 5: Print Current App Version
- This step reads the current version from a `version.md` file and sets it as an environment variable.

### Step 6: Generate Modified Deployment YAML
- This step creates modified deployment YAML files with the updated image tags based on the current version.

### Step 7: Build Microservice1 Image
- This step builds the Docker image for `microservice1` using the Dockerfile in the `service1` directory.

### Step 8: Build Microservice2 Image
- This step builds the Docker image for `microservice2` using the Dockerfile in the `service2` directory.

### Step 9: Print Docker Images
- This step lists Docker images to verify that the images have been built correctly.

### Step 10: Deploy to Minikube
- This step deploys the modified Kubernetes deployments and services to Minikube.

### Step 11: List Deployments
- This step lists the Kubernetes deployments in the cluster.

### Step 12: List Services
- This step lists the Kubernetes services in the cluster.

### Step 13: List Pods
- This step lists the pods in the cluster.

### Step 14: Wait for Pods to Be Ready
- This step waits for the pods to be ready by running a script (`check_pods.sh`) with a timeout of 15 minutes.

### Step 15: Test Service URLs
- This step tests the service URLs by listing available services, displaying details of `service2-service`, and making a curl request to the service.

## How to Run

1. Ensure you have a Minikube cluster set up and running with the Docker driver.
2. Place this GitHub Actions workflow file (`.github/workflows/deploy-to-minikube.yml`) in your project repository.
3. Modify the deployment and service YAML files (`deployment-service1.yaml`, `deployment-service2.yaml`, `service-service1.yaml`, `service-service2.yaml`) to match your project's specifications.
4. Make sure you have a `version.md` file in your repository with the version information.
5. Ensure your Kubernetes services are of type NodePort.
6. Push your code changes to the branch specified in the workflow (`05-setup-github-workflow` in this example).
7. The workflow will automatically trigger on a push event to the specified branch, and all the deployment and testing steps will be executed in the GitHub Actions pipeline.