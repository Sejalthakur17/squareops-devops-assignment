# SquareOps DevOps Assignment

## Overview

This repository contains my solution for the **SquareOps DevOps Take-Home Assignment**.

The project deploys the **Docker Example Voting Application** on Kubernetes and demonstrates Kubernetes best practices including StatefulSets, Secrets, Persistent Storage, resource management, health probes, and CI/CD using GitHub Actions.

---

# Architecture

```
                 User
                   │
                   ▼
          Vote Application (Flask)
                   │
                   ▼
                Redis Queue
                   │
                   ▼
               Worker Service
                   │
                   ▼
        PostgreSQL StatefulSet
                   │
                   ▼
          Result Application
```

---

# Tech Stack

- Kubernetes
- Docker
- Docker Hub
- GitHub Actions
- Kind
- Redis
- PostgreSQL
- YAML

---

# Project Structure

```
.
├── .github/
│   └── workflows/
│       └── ci-cd.yml
│
├── k8s-specifications/
│   ├── db-statefulset.yaml
│   ├── db-service.yaml
│   ├── redis-deployment.yaml
│   ├── redis-service.yaml
│   ├── vote-deployment.yaml
│   ├── vote-service.yaml
│   ├── result-deployment.yaml
│   ├── result-service.yaml
│   ├── worker-deployment.yaml
│   ├── secret.yaml
│   └── ingress.yaml
│
├── vote/
├── result/
├── worker/
├── bootstrap.sh
└── README.md
```

---

# Improvements Made

The original Kubernetes manifests were enhanced with the following improvements:

### Kubernetes Secret

- PostgreSQL credentials were moved into a Kubernetes Secret.
- Avoids storing sensitive credentials in plain text.

---

### PostgreSQL StatefulSet

- Converted PostgreSQL Deployment to StatefulSet.
- Added Persistent Volume Claim.
- Ensures data persistence across pod restarts.

---

### Resource Requests & Limits

Added CPU and Memory requests/limits for application containers.

Benefits:

- Better scheduling
- Prevents excessive resource consumption

---

### Liveness & Readiness Probes

Configured health checks for application containers.

Benefits:

- Automatic recovery
- Better availability
- Reliable rolling updates

---

### GitHub Actions CI/CD

Implemented GitHub Actions workflow to:

- Build Docker Images
- Push images to Docker Hub
- Validate Kubernetes manifests
- Deploy to Kind Cluster
- Run smoke tests

---

# Kubernetes Resources

## Deployments

- Vote
- Result
- Worker
- Redis

## StatefulSet

- PostgreSQL

## Services

- Vote Service
- Result Service
- Redis Service
- PostgreSQL Service

## Secret

```
postgres-secret
```

Contains:

- POSTGRES_USER
- POSTGRES_PASSWORD

---

# Prerequisites

Install:

- Docker Desktop
- kubectl
- Kind
- Git

Verify installation:

```bash
docker --version
kubectl version --client
kind version
git --version
```

---

# Deployment

Clone Repository

```bash
git clone https://github.com/Sejalthakur17/squareops-devops-assignment.git

cd squareops-devops-assignment
```

---

## One Command Deployment

```bash
./bootstrap.sh
```

Or deploy manually.

---

## Create Secret

```bash
kubectl apply -f k8s-specifications/secret.yaml
```

---

## Deploy Database

```bash
kubectl apply -f k8s-specifications/db-statefulset.yaml
kubectl apply -f k8s-specifications/db-service.yaml
```

---

## Deploy Redis

```bash
kubectl apply -f k8s-specifications/redis-deployment.yaml
kubectl apply -f k8s-specifications/redis-service.yaml
```

---

## Deploy Applications

```bash
kubectl apply -f k8s-specifications/vote-deployment.yaml
kubectl apply -f k8s-specifications/vote-service.yaml

kubectl apply -f k8s-specifications/result-deployment.yaml
kubectl apply -f k8s-specifications/result-service.yaml

kubectl apply -f k8s-specifications/worker-deployment.yaml
```

---

## Deploy Ingress

```bash
kubectl apply -f k8s-specifications/ingress.yaml
```

---

# Verify Deployment

Pods

```bash
kubectl get pods
```

Services

```bash
kubectl get svc
```

Secrets

```bash
kubectl get secret
```

Persistent Volume Claims

```bash
kubectl get pvc
```

Ingress

```bash
kubectl get ingress
```

---

# Testing the Application

Run:

```bash
kubectl port-forward service/vote 8080:8080
```

Open another terminal.

Run:

```bash
kubectl port-forward service/result 8081:8081
```

Open browser:

Vote Application

```
http://localhost:8080
```

Result Application

```
http://localhost:8081
```

Cast a vote and verify the Result application updates automatically.

---

# CI/CD

The GitHub Actions workflow automatically:

- Validates Kubernetes manifests
- Builds Docker images
- Pushes images to Docker Hub
- Creates a Kind cluster
- Deploys the application
- Runs smoke tests

Workflow:

```
.github/workflows/ci-cd.yml
```

---

# Docker Images

Docker Hub

https://hub.docker.com/r/sejalthakur/vote-app

Published Images

- vote-latest
- result-latest
- worker-latest

---

# Troubleshooting

## Pods Not Running

```bash
kubectl describe pod <pod-name>

kubectl logs <pod-name>
```

---

## Worker Not Updating Results

Verify:

```bash
kubectl get pods
```

Ensure:

- Redis is Running
- Worker is Running
- PostgreSQL is Running

---

## Port Forward Not Working

Restart:

```bash
kubectl port-forward service/vote 8080:8080

kubectl port-forward service/result 8081:8081
```

---

# Trade-offs

- Used GitHub Actions for CI/CD because of its seamless GitHub integration.
- Used Kubernetes Service Port Forwarding for local verification.
- Used StatefulSet only for PostgreSQL since persistent storage is required.

---

# Loom Video

Loom Recording:

https://www.loom.com/share/ad339e1e59404f85b655c58d5fc6bd54

---

# Screenshots

Include:

- GitHub Repository
- Kubernetes Pods
- Kubernetes Services
- Kubernetes Secrets
- Persistent Volume Claims
- Vote Application
- Result Application
- GitHub Actions Success
- Docker Hub Images

---

# Author

## Sejal Thakur

GitHub

https://github.com/Sejalthakur17

Docker Hub

https://hub.docker.com/u/sejalthakur

---