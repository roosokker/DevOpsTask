#!/bin/bash
echo "=== Kubernetes Application Cleanup ==="
echo ""

echo "1. Deleting applications..."
kubectl delete -f applications/juice-shop/ --ignore-not-found=true
kubectl delete -f applications/ingress-controller/ --ignore-not-found=true

echo "2. Deleting security policies..."
kubectl delete -f security/ --ignore-not-found=true

echo "3. Cleaning up namespaces..."
kubectl delete namespace juice-shop --ignore-not-found=true
kubectl delete namespace ingress-nginx --ignore-not-found=true

echo "4. Checking remaining resources..."
echo "Pods:"
kubectl get pods -A
echo ""
echo "Services:"
kubectl get svc -A
echo ""
echo "Ingress:"
kubectl get ingress -A

echo "=== Cleanup Complete ==="
echo "Note: This only removes applications, not the Kubernetes cluster itself"
echo "Use cluster-setup/reset-cluster.sh to completely reset the cluster"