echo TEARING DOWN A2

echo
echo DELETE BACKEND 
kubectl delete -f ./manifests/backend.yaml

echo
echo DELETE SERVICE 
kubectl delete -f ./manifests/service.yaml

echo
echo DELETE INGRESS CONTROLLER 
kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo
echo DELETE INGRESS 
kubectl delete -f ./manifests/ingress.yaml

echo
echo DELETE CLUSTER 
kind delete cluster --name kind-1

echo
echo A2 TEARDOWN DONE!
