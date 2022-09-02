echo TEARING DOWN A3

echo
echo DELETE HPA
kubectl delete -f ./manifests/hpa.yaml

echo
echo DELETE METRICS SERVER
kubectl delete -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

echo
echo DELETE BACKEND-ZONE-AWARE 
kubectl delete -f ./manifests/backend-zone-aware.yaml

echo
echo DELETE SERVICE-ZONE-AWARE
kubectl delete -f ./manifests/service-zone-aware.yaml

echo
echo DELETE INGRESS CONTROLLER 
kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo
echo DELETE INGRESS-ZONE-AWARE
kubectl delete -f ./manifests/ingress-zone-aware.yaml

echo
echo DELETE CLUSTER
kind delete cluster --name kind-1

echo
echo A3 TEARDOWN DONE!
