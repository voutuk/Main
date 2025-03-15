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

  echo "Successfully logged in and retrieved AKS credentials."
'

doppler run -- az aks update -n gosell-aks -g gosell-aks-cluster --attach-acr gosellbackupreadypika