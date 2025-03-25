doppler run -- envsubst < ./values-template.yaml > ./helm/values.yaml
helm install nginx-ingress ingress-nginx/ingress-nginx \
  --namespace olx-app \
  --set controller.replicaCount=1 \
  --set controller.nodeSelector."kubernetes\.io/os"=linux \
  --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux \
  --set 'controller.service.annotations.service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path=/'