export TF_VAR_doppler_token="" #View file .env.example
#INFO: Doppler vars CLIENT_ID, CLIENT_SECRET, TENANT_ID, SSHPUB

terraform plan
terraform apply -target=module.resource_group -auto-approve
terraform apply -target=module.create_nsg -auto-approve
terraform apply -target=module.main_instance -auto-approve
terraform apply -target=module.build_agent_instance -auto-approve
terraform apply -target=module.rule_block_ssh -auto-approve
terraform apply -target=module.aks_cluster -auto-approve
terraform apply -target=module.backup_storage -auto-approve
terraform apply -target=module.ansible_inventory -auto-approve


# terraform refresh
terraform state list