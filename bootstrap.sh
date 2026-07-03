#!/bin/bash

set -e

echo "Creating Kind cluster..."

kind create cluster --name voting-app || echo "Kind cluster already exists"

echo "Deploying Kubernetes resources..."

kubectl apply -f k8s-specifications/secret.yaml
kubectl apply -f k8s-specifications/db-statefulset.yaml
kubectl apply -f k8s-specifications/db-service.yaml
kubectl apply -f k8s-specifications/redis-deployment.yaml
kubectl apply -f k8s-specifications/redis-service.yaml
kubectl apply -f k8s-specifications/vote-deployment.yaml
kubectl apply -f k8s-specifications/vote-service.yaml
kubectl apply -f k8s-specifications/result-deployment.yaml
kubectl apply -f k8s-specifications/result-service.yaml
kubectl apply -f k8s-specifications/worker-deployment.yaml

echo "Waiting for Pods..."

kubectl wait --for=condition=Ready pods --all --timeout=300s

echo ""
echo "Deployment Complete!"
echo ""
echo "Run:"
echo "kubectl port-forward service/vote 8080:8080"
echo "kubectl port-forward service/result 8081:8081"