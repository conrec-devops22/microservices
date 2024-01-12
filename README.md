# Deploy to Minikube

This repository contains a GitHub Actions workflow for deploying microservices to Minikube in different environments (QA, UAT, and PROD). The deployment is triggered on the `07-testing-steps` branch push events.

## Workflow Overview

### 1. Test Job
- **Name:** Test
- **Runs on:** Ubuntu latest
- **Permissions:** Writes to issues
- **Steps:**
  - Uses a script to check the status of the latest GitHub Actions workflow run. If the status is "failure," the job exits with an error.

### 2. Build Job
- **Name:** Build
- **Runs on:** Ubuntu latest
- **Dependencies:** Depends on the success of the Test job
- **Steps:**
  - Checks out the repository code.
  - Starts Minikube with the Docker driver.
  - Sets up the Docker environment for Minikube.
  - Prints the current version of the application by reading it from the `version.md` file.
  - Generates modified deployment YAML files by replacing the version placeholders with the current version.
  - Builds Docker images for microservice1 and microservice2.
  - Prints the Docker images.

### 3. QA Deployment Job
- **Name:** Deploy to QA
- **Runs on:** Ubuntu latest
- **Dependencies:** Depends on the success of the Build job
- **Steps:**
  - Deploys the modified deployment YAML files and services to Minikube.
  - Lists deployments, services, and pods.
  - Waits for pods to be ready.
  - Tests service URLs.

### 4. UAT Deployment Job
- **Name:** Deploy to UAT
- **Runs on:** Ubuntu latest
- **Dependencies:** Depends on the success of the Build job
- **Steps:**
  - Deploys the modified deployment YAML files and services to Minikube.
  - Lists deployments, services, and pods.
  - Waits for pods to be ready.
  - Tests service URLs.

### 5. Production Deployment Job
- **Name:** Deploy to PROD
- **Runs on:** Ubuntu latest
- **Dependencies:** Depends on the success of the UAT Deployment job
- **Steps:**
  - Requires manual approval before deployment (approvers: jonconinf).
  - Deploys the modified deployment YAML files and services to Minikube.
  - Lists deployments, services, and pods.
  - Waits for pods to be ready.
  - Tests service URLs.

## Note
- The deployment steps include modifying deployment YAML files, building Docker images, deploying to Minikube, and performing various checks to ensure the successful deployment of microservices in different environments.
- Manual approvals are required before deploying to PROD environment.
- The workflow utilizes Minikube for Kubernetes cluster management and Docker for containerization.
- Make sure to check and modify the environment-specific configurations and scripts according to your project requirements before using this workflow.
- Because of how Minikube works, the deploy is not going to work. We need to recreate the cluster on every step. This is only working for demonstration purposes.
