#!/bin/bash
echo "=== Kubernetes Cluster Reset ==="

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root or with sudo"
    exit 1
fi

echo "WARNING: This will completely reset Kubernetes cluster"
read -p "Are you sure? (y/n): " CONFIRM

if [ "$CONFIRM" != "y" ]; then
    echo "Reset cancelled"
    exit 0
fi

echo "1. Resetting kubeadm..."
kubeadm reset -f

echo "2. Cleaning up files..."
rm -rf /etc/kubernetes/
rm -rf /var/lib/etcd/
rm -rf /var/lib/kubelet/
rm -rf $HOME/.kube
rm -rf /etc/cni/net.d/

echo "3. Cleaning network interfaces..."
ip link delete cni0 2>/dev/null || true
ip link delete flannel.1 2>/dev/null || true

echo "4. Cleaning iptables..."
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X

echo "5. Restarting kubelet..."
systemctl daemon-reload
systemctl restart kubelet

echo "=== Cluster reset completed ==="
echo "You can now run kubeadm init to create a fresh cluster"