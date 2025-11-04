#!/bin/bash
echo "=== Kubernetes Worker Node Join Script ==="

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root or with sudo"
    exit 1
fi

echo "This script expects the join command from master node"
echo ""
echo "If you need to reset previous join attempts, run:"
echo "kubeadm reset -f"
echo "rm -rf /etc/kubernetes/ /var/lib/kubelet/ /$HOME/.kube"
echo ""
echo "Please paste the join command from master node:"
read -p "Join command: " JOIN_CMD

if [ -z "$JOIN_CMD" ]; then
    echo "Error: No join command provided"
    exit 1
fi

echo "Joining cluster..."
$JOIN_CMD

if [ $? -eq 0 ]; then
    echo ""
    echo "=== WORKER NODE JOINED SUCCESSFULLY ==="
    echo "Check status on master node with: kubectl get nodes"
    echo "Worker should show 'Ready' status after 1-2 minutes"
else
    echo ""
    echo "=== JOIN FAILED ==="
    echo "Common solutions:"
    echo "1. Reset and retry: kubeadm reset -f"
    echo "2. Check network connectivity to master"
    echo "3. Verify token is still valid"
    echo "4. Use --ignore-preflight-errors=all if needed"
fi