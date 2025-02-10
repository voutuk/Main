# GitHub: https://github.com/voutuk/main
# License: MIT License with Non-Commercial Use Restriction
#
# Purpose: This Terraform configuration deploys a development instance 
#          with 2 build-agent VMs, 1 main VM, 1 NSG, and an NSG rule.
# Prerequisites: A Doppler .env secret key.
# Variables: ./variables.tf
#
# Azure Provider: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
# Azure API Provider: https://registry.terraform.io/providers/azure/azapi/latest/docs
# Doppler Provider: https://registry.terraform.io/providers/DopplerHQ/doppler/latest/docs

# Module to create the Resource Group
module "resource_group" {
  source              = "./modules/resource_group"
  azure_region        = var.azure_region
  resource_group_name = var.resource_group_name
}

# Module to create the Network Security Group
module "create_nsg" {
  source              = "./modules/nsg"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  nsg_name            = "vm-nsg"
  vnet_address_space  = "10.0.0.0/16"
}

# Main VM
module "main_instance" {
  source              = "./modules/compute/main_instance"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  vm_name             = var.main_vm_name
  vm_size             = var.main_instance_vm_size
  admin_username      = var.vm_admin_username
  vm_private_ip       = var.vm_private_ip
  ssh_public_key      = data.doppler_secrets.az-creds.map.SSHPUB
  vm_sku              = var.vm_sku
  nsg_id              = module.create_nsg.nsg_id
}

# Build-Agent VM
module "build_agent_instance" {
  source              = "./modules/compute/build_agent_instance"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  vm_name             = "build-ub"
  subnet_id           = module.main_instance.subnet_id
  vm_size             = var.build_agent_vm_size
  admin_username      = var.vm_admin_username
  ssh_public_key      = data.doppler_secrets.az-creds.map.SSHPUB
  instance_count      = var.instance_count
  vm_sku              = var.vm_sku
  nsg_id              = module.create_nsg.nsg_id
}

# Module to block SSH access (deny)
module "rule_block_ssh" {
  source              = "./modules/nsg_rule"
  resource_group_name = module.resource_group.resource_group_name
  nsg_name            = "vm-nsg"
  priority            = 150
  depends_on          = [module.create_nsg]
}

# Module to create the AKS cluster
module "aks_cluster" {
  source                         = "./modules/aks"
  aks_resource_group_location    = var.resource_group_location
  aks_resource_group_name_prefix = var.resource_group_name_prefix
  aks_vm_size                    = var.aks_vm_size
  aks_node_count                 = var.node_count
  aks_admin_username             = var.aks_admin_username
  ssh_public_key_data            = data.doppler_secrets.az-creds.map.SSHPUB
}

# Module to create a Storage Account for backups
module "backup_storage" {
  source                   = "./modules/backup_storage"
  resource_group_name      = module.resource_group.resource_group_name
  location                 = module.resource_group.resource_group_location
  backup_storage_prefix    = var.backup_storage_prefix
  container_name           = "backups"
}

# Module to create the Ansible Inventory
module "ansible_inventory" {
  source           = "./modules/ansible_inventory"
  main_instance_ip = module.main_instance.public_ip
  build_agent_ips  = module.build_agent_instance.public_ips
  admin_username   = var.vm_admin_username
  inventory_path   = "../An/hosts"
}