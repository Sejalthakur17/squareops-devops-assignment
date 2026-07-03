# SquareOps DevOps Assignment

## Overview

This repository contains the deployment of the Example Voting Application using Kubernetes. The project demonstrates container orchestration, Kubernetes resources, NGINX Ingress, secrets management, and CI/CD using GitHub Actions with Docker Hub.

---

## Project Architecture

```
                User
                  │
                  ▼
          NGINX Ingress Controller
                  │
      ┌───────────┴────────────┐
      │                        │
      ▼                        ▼
 Vote Service              Result Service
      │                        │
      ▼                        ▼
 Vote Pod                 Result Pod
      │                        ▲
      │                        │
      ▼                        │
 Redis Service ─── Worker Pod ─┘
                    │
                    ▼
             PostgreSQL Service
                    │
                    ▼
             PostgreSQL StatefulSet
```

---

## Tech Stack

- Kubernetes
- Docker
- Docker Hub
- GitHub Actions
- NGINX Ingress Controller
- Redis
- PostgreSQL
- YAML

---

## Project Structure

```
.
├── .github
│   └── workflows
│       └── ci-cd.yml
│
├── k8s-specifications
│   ├── vote-deployment.yaml
│   ├── vote-service.yaml
│   ├── result-deployment.yaml
│   ├── result-service.yaml
│   ├── worker-deployment.yaml
│   ├── redis-deployment.yaml
│   ├── redis-service.yaml
│   ├── db-statefulset.yaml
│   ├── db-service.yaml
│   ├── secret.yaml
│   └── ingress.yaml
│
├── vote
├── result
├── worker
└── README.md
```

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

Stores:

- POSTGRES_USER
- POSTGRES_PASSWORD

---

# CI/CD Pipeline

GitHub Actions automatically:

- Builds Vote image
- Builds Result image
- Builds Worker image
- Pushes images to Docker Hub

Workflow file:

```
.github/workflows/ci-cd.yml
```

---

# Docker Images

Docker Hub Repository:

```
https://hub.docker.com/r/sejalthakur/vote-app
```

Images:

- vote-latest
- result-latest
- worker-latest

---

# Deployment Steps

## Clone Repository

```bash
git clone https://github.com/Sejalthakur17/squareops-devops-assignment.git

cd squareops-devops-assignment
```

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

Check Pods

```bash
kubectl get pods
```

Check Services

```bash
kubectl get svc
```

Check Ingress

```bash
kubectl get ingress
```

---

# Access Application

Vote Application

```
http://localhost:8088
```

Result Application

```
http://localhost:8088/result
```

Port Forward

```bash
kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 8088:80
```

---

# CI/CD Result

GitHub Actions completed successfully:

- Vote Image Built
- Result Image Built
- Worker Image Built
- Docker Images Published

---

# Author

**Sejal Thakur**

GitHub:
https://github.com/Sejalthakur17

Docker Hub:
https://hub.docker.com/u/sejalthakur