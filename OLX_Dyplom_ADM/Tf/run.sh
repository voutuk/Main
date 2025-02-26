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


az login --service-principal \
  --username "d44739fa-e64a-4a6d-9456-ee6cb4c00628" \
  --password "6jV8Q~eMgyacqTgEN-4uj7FUaV7Y1l4KDuiora7B" \
  --tenant "ae561515-9385-4483-bef2-aec8255d3705"
