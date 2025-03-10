doppler run -- az login --service-principal --username $ARM_CLIENT_ID --password $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID
az aks get-credentials --resource-group gosell-aks-cluster --name gosell-aks
