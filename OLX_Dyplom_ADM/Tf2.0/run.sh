terraform apply -target=module.resource_group
terraform apply -target=module.create_nsg
terraform apply -target=module.main_instance
terraform apply -target=module.build_agent_instance

az vm show -d -g dev-environment-rg -n dev-vm --query "publicIps" -o tsv
terraform apply -target=module.rule_block_ssh