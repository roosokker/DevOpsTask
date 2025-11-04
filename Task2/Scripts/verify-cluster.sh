#!/bin/bash
echo "=== Kubernetes Cluster Verification ==="
echo ""

echo "1. Node Status:"
kubectl get nodes -o wide
echo ""

echo "2. System Pods Status:"
kubectl get pods -n kube-system
echo ""

echo "3. Application Pods Status:"
kubectl get pods -A --field-selector=metadata.namespace!=kube-system
echo ""

echo "4. Services:"
kubectl get svc -A
echo ""

echo "5. Ingress:"
kubectl get ingress -A
echo ""

echo "6. Network Policies:"
kubectl get networkpolicies -A
echo ""

echo "7. Cluster Info:"
kubectl cluster-info
echo ""

echo "8. Component Status:"
kubectl get componentstatuses
echo ""

echo "=== Verification Complete ==="