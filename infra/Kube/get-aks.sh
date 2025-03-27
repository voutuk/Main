doppler run -- bash -c '
  # Login using service principal
  az login --service-principal \
    --username "$ARM_CLIENT_ID" \
    --password "$ARM_CLIENT_SECRET" \
    --tenant "$ARM_TENANT_ID"

  # Get AKS credentials
  az aks get-credentials \
    --resource-group gosell-aks-cluster \
    --name gosell-aks

  az aks get-credentials \
    --resource-group gosell-aks-cluster \
    --name onix-aks

  echo "Successfully logged in and retrieved AKS credentials."
'

doppler run -- bash -c 'az aks update -n gosell-aks -g gosell-aks-cluster --attach-acr "$AZURE_CONTAINER_REGISTRY"'

doppler run -- bash -c 'az aks update -n onix-aks -g gosell-aks-cluster --attach-acr "$AZURE_CONTAINER_REGISTRY"'