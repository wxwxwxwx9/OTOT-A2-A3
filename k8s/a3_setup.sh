# METRICS-SERVER
# need to start metrics server manually because we have to edit the yaml file after applying
# 1. apply metrics server
# kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
# 2. open yaml file to edit
# kubectl -nkube-system edit deploy/metrics-server
# 3. add flag 
# add flag `--kubelet-insecure-tls` to `deployment.spec.containers[].args[]`
# 4. restart metrics-server
# kubectl -nkube-system rollout restart deploy/metrics-server
# 5. check metrics-server works properly
# kubectl get deploy,svc -n kube-system | egrep metrics-server

echo SETTING UP A3

echo CREATING CLUSTER NODES LOCALLY
kind create cluster --name kind-1 --config ./kind/cluster-config.yaml

echo
echo CHECKING CLUSTER NODES CREATED PROPERLY
kubectl get nodes
kubectl cluster-info

echo
echo KINDLY SETUP METRICS-SERVER MANUALLY
echo need to start metrics server manually because we have to edit the yaml file after applying
echo 1. apply metrics server
echo kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
echo 2. open yaml file to edit
echo kubectl -nkube-system edit deploy/metrics-server
echo 3. add flag 
echo add flag --kubelet-insecure-tls to deployment.spec.containers[].args[]
echo 4. restart metrics-server
echo kubectl -nkube-system rollout restart deploy/metrics-server
echo 5. check metrics-server works properly
echo "kubectl get deploy,svc -n kube-system | egrep metrics-server"

echo
echo CREATING HPA
kubectl apply -f ./manifests/hpa.yaml

echo
echo CREATING BACKEND-ZONE-AWARE
kubectl apply -f ./manifests/backend-zone-aware.yaml

echo
echo CHECKING BACKEND-ZONE-AWARE CREATED SUCCESSFULLY 
kubectl get deployment
kubectl get po -lapp=backend-zone-aware

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
echo CREATING SERVICE-ZONE-AWARE 
kubectl apply -f ./manifests/service-zone-aware.yaml

echo
echo CHECKING SERVICE-ZONE-AWARE CREATED SUCCESSFULLY 
kubectl get svc

echo
echo CREATING INGRESS-ZONE-AWARE 
kubectl apply -f ./manifests/ingress-zone-aware.yaml

echo
echo CHECKING INGRESS-ZONE-AWARE CREATED SUCCESSFULLY 
kubectl get ingress

echo
echo A3 SETUP DONE!

