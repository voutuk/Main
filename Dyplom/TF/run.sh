terraform plan -var-file="terraform.tfvars"
terraform apply -target=module.backup_bucket -var-file="terraform.tfvars" -auto-approve