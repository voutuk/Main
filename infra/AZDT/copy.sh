doppler run -- bash -c '
  # Login using service principal
  az login --service-principal \
    --username "$ARM_CLIENT_ID" \
    --password "$ARM_CLIENT_SECRET" \
    --tenant "$ARM_TENANT_ID"

  # Copy files to Azure Storage - using account key authentication
  az storage file upload-batch \
    --account-name "$AZURE_STORAGE_ACCOUNT" \
    --account-key "$AZURE_STORAGE_KEY" \
    --destination "jenkins-data" \
    --source "./jenkins-home" \
    --pattern "*"
'