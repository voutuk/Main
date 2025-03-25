doppler run -- envsubst < ./backend-template.yaml > ./v3/backend-deployment.yaml
doppler run -- envsubst < ./frontend-template.yaml > ./v3/frontend-deployment.yaml
kubectl create namespace olx-app
kubectl apply -f ./v3/
helm install nginx-ingress ingress-nginx/ingress-nginx \
  --namespace gosell \
  --set controller.replicaCount=1 \
  --set controller.nodeSelector."kubernetes\.io/os"=linux \
  --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux \
  --set 'controller.service.annotations.service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path=/'