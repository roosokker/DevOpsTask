#!/bin/bash

set -e
echo "Kubernetes Deployment"

# Check node type
if [ -f /etc/kubernetes/admin.conf ] || kubectl get nodes >/dev/null 2>&1; then
    echo "Deploying on Master Node"
    
    # Run prerequisites
    ./cluster-setup/01-prerequisites.sh
    
    # Initialize master (if not already initialized)
    if [ ! -f /etc/kubernetes/admin.conf ]; then
        ./cluster-setup/02-master-init.sh
        sleep 30
    fi
    
    # Deploy applications
    kubectl apply -f applications/juice-shop/
    kubectl apply -f applications/ingress-controller/
    kubectl apply -f security/
    
    # Wait and verify
    sleep 20
    ./scripts/verify-cluster.sh
    
    # Show join command for workers
    echo ""
    echo "🔗 Worker Join Command:"
    kubeadm token create --print-join-command
    
else
    echo "🔧 Deploying on Worker Node"
    
    # Run prerequisites
    ./cluster-setup/01-prerequisites.sh
    
    # Ask for join command
    echo "Please provide the join command from master:"
    read -p "Join command: " JOIN_CMD
    
    if [ -n "$JOIN_CMD" ]; then
        $JOIN_CMD
    else
        echo "No join command provided"
        exit 1
    fi
fi

echo "Deployment completed!"