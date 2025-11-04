# Kubernetes Cluster Architecture

## Overview
This document describes the architecture of the Kubernetes cluster built for the interview task.

## Components

### 1. Infrastructure
- **Master Node**: Control plane components
- **Worker Node**: Application workloads
- **Network**: Flannel overlay network

### 2. Control Plane (Master)
- **kube-apiserver**: Cluster API endpoint
- **etcd**: Distributed key-value store
- **kube-scheduler**: Pod scheduling decisions
- **kube-controller-manager**: Cluster state management

### 3. Worker Node
- **kubelet**: Node agent
- **kube-proxy**: Network proxy
- **Container Runtime**: containerd + Docker
- **Pods**: Application containers

### 4. Networking
- **Flannel**: Overlay network for pod-to-pod communication
- **Services**: Internal load balancing
- **Ingress**: External HTTP traffic routing

### 5. Applications
- **Juice Shop**: Sample vulnerable web application
- **Nginx Ingress**: External traffic controller

## Network Flow

### External Access