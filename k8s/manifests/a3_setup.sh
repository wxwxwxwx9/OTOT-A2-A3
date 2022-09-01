kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl apply -f hpa.yaml
kubectl apply -f backend-zone-aware.yaml
