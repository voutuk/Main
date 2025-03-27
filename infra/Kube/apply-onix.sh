doppler run -- envsubst < ./onix-template.yaml > ./onix/values.yaml
kubectl create namespace onix-app
helm install nginx-ingress ingress-nginx/ingress-nginx \
  --namespace onix-app \
  --set controller.replicaCount=1 \
  --set controller.nodeSelector."kubernetes\.io/os"=linux \
  --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux \
  --set 'controller.service.annotations.service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path=/'