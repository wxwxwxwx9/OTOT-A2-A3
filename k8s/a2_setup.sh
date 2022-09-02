echo SETTING UP A2

echo
echo CREATING CLUSTER NODES LOCALLY 
kind create cluster --name kind-1 --config ./kind/cluster-config.yaml

echo
echo CHECKING CLUSTER NODES CREATED PROPERLY
kubectl get nodes
kubectl cluster-info

echo
echo CREATING BACKEND
kubectl apply -f ./manifests/backend.yaml

echo
echo CHECKING BACKEND CREATED SUCCESSFULLY 
kubectl get deployment
kubectl get po -lapp=backend

echo
echo CHECK NODE INGRESS-READY
kubectl get nodes -L ingress-ready

echo
echo CREATE INGRESS CONTROLLER
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo
echo SLEEP 180 SECS TO WAIT INGRESS CONTROLLER TO SETUP PROPERLY
sleep 180 

echo
echo CHECK INGRESS CONTROLLER CREATED SUCCESSFULLY 
kubectl -n ingress-nginx get deploy

echo
echo CREATING SERVICE 
kubectl apply -f ./manifests/service.yaml

echo
echo CHECKING SERVICE CREATED SUCCESSFULLY 
kubectl get svc

echo
echo CREATING INGRESS 
kubectl apply -f ./manifests/ingress.yaml

echo
echo CHECKING INGRESS CREATED SUCCESSFULLY 
kubectl get ingress

echo
echo A2 SETUP DONE!
