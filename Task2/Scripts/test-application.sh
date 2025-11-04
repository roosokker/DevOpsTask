#!/bin/bash
echo "=== Application Testing ==="
echo ""

# Get worker node IP
WORKER_IP=$(kubectl get nodes -o wide | grep -v master | grep -v CONTROL | awk 'NR==2{print $6}')
if [ -z "$WORKER_IP" ]; then
    WORKER_IP=$(kubectl get nodes -o wide | grep -v NAME | head -1 | awk '{print $6}')
fi

echo "Worker Node IP: $WORKER_IP"
echo ""

echo "1. Testing Direct Access (NodePort 30081):"
curl -s http://$WORKER_IP:30081 | grep -o "<title>.*</title>" || echo "Direct access test failed"
echo ""

echo "2. Testing Ingress Access (Port 30080 with Host header):"
curl -s -H "Host: juice-shop.local" http://$WORKER_IP:30080 | grep -o "<title>.*</title>" || echo "Ingress access test failed"
echo ""

echo "3. Testing Internal Service Access:"
echo "Starting port-forward..."
kubectl port-forward -n juice-shop svc/juice-shop-service 8080:80 > /dev/null 2>&1 &
PORT_FORWARD_PID=$!
sleep 3

curl -s http://localhost:8080 | grep -o "<title>.*</title>" || echo "Internal service test failed"

kill $PORT_FORWARD_PID 2>/dev/null
echo ""

echo "4. Pod Logs Check:"
JUICE_POD=$(kubectl get pods -n juice-shop -l app=juice-shop -o name | head -1)
if [ -n "$JUICE_POD" ]; then
    echo "Recent logs from $JUICE_POD:"
    kubectl logs -n juice-shop $JUICE_POD --tail=5
else
    echo "No Juice Shop pods found"
fi
echo ""

echo "=== Testing Complete ==="