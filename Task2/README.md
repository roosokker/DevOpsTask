# Kubernetes Interview Task - Complete Implementation

## 📖 Overview
A production-like Kubernetes cluster with multi-node setup, networking, application deployment, and security configurations.

## 🏗️ Architecture
- **Master Node**: Control plane (API Server, etcd, Scheduler, Controller)
- **Worker Node**: Application workloads (Juice Shop, Ingress Controller)
- **Network**: Flannel overlay network
- **Ingress**: Nginx Ingress Controller for external access

## 🚀 Quick Start

### Prerequisites
- 2 Ubuntu 20.04+ VMs (2GB RAM, 2 CPU, 20GB disk each)
- Network connectivity between VMs

### Deployment Steps
1. Run prerequisites on both nodes:
   ```bash
   ./cluster-setup/01-prerequisites.sh