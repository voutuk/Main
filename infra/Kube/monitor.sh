helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install monitoring prometheus-community/kube-prometheus-stack \
  --namespace monitoring --create-namespace

helm upgrade promtail grafana/promtail \
  --namespace monitoring \
  --set loki.serviceName=<IP або DNS Loki> \
  --set loki.servicePort=3100