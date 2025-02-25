export TF_VAR_doppler_token="" #View file .env.example
#INFO: Doppler vars CLIENT_ID, CLIENT_SECRET, TENANT_ID, SSHPUB

terragrunt plan
terragrunt apply --parallelism=10 -auto-approve
terragrunt apply -target=module.main_instance -auto-approve
terragrunt apply -target=module.build_agent_instance -auto-approve
terragrunt apply -target=module.aks_cluster -auto-approve
terragrunt apply -target=module.backup_storage -auto-approve
terragrunt apply -target=module.ansible_inventory -auto-approve
terragrunt apply -target=module.main_rule_block_ssh -auto-approve       #INFO: Block SSH use after ansible playbook
terragrunt apply -target=module.agent_rule_block_ssh -auto-approve      #INFO: Block SSH use after ansible playbook


terragrunt destroy -target=module.create_main_nsg -auto-approve
terragrunt destroy -target=module.create_agent_nsg -auto-approve
# terragrunt refresh
terragrunt state list

terramate cloud login --github
terramate create --all-terragrunt