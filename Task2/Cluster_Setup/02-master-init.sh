#!/bin/bash
echo "=== Kubernetes Master Node Initialization ==="

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root or with sudo"
    exit 1
fi

echo "1. Initializing Kubernetes cluster..."
kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$(hostname -I | awk '{print $1}') --ignore-preflight-errors=all

echo "2. Configuring kubectl for current user..."
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Also configure for root user
export KUBECONFIG=/etc/kubernetes/admin.conf
echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> ~/.bashrc

echo "3. Installing Flannel network plugin..."
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

echo "4. Generating worker join command..."
JOIN_COMMAND=$(kubeadm token create --print-join-command)

echo ""
echo "=== MASTER NODE INITIALIZED SUCCESSFULLY ==="
echo ""
echo "WORKER JOIN COMMAND (SAVE THIS):"
echo "$JOIN_COMMAND"
echo ""
echo "Next steps:"
echo "1. Run the above join command on worker node"
echo "2. Wait 2-3 minutes for network to initialize"
echo "3. Run: kubectl get nodes (to verify worker joined)"
echo "4. Deploy applications from applications/ directory"