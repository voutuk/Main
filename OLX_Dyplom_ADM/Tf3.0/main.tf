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

# GitHub: https://github.com/voutuk/main
# License: MIT License with Non-Commercial Use Restriction

# Resource Groups for different components
module "backup_storage_rg" {
  source              = "./modules/resource_group"
  resource_group_name = "${var.rg_prefix}-backup-storage"
  location            = "westeurope"  # You can change this region
  tags = {
    purpose = "backup_storage"
  }
}

module "aks_cluster_rg" {
  source              = "./modules/resource_group"
  resource_group_name = "${var.rg_prefix}-aks-cluster"
  location            = "northeurope"  # You can change this region
  tags = {
    purpose = "aks_cluster"
  }
}

module "main_instance_rg" {
  source              = "./modules/resource_group"
  resource_group_name = "${var.rg_prefix}-main-instance"
  location            = "westus"  # You can change this region
  tags = {
    purpose = "main_instance"
  }
}

module "build_agent_rg" {
  source              = "./modules/resource_group"
  resource_group_name = "${var.rg_prefix}-build-agents"
  location            = "eastus"  # You can change this region
  tags = {
    purpose = "build_agent_instance"
  }
}

# Network Security Group
module "create_main_nsg" {
  source              = "./modules/nsg"
  resource_group_name = module.main_instance_rg.resource_group_name
  location            = module.main_instance_rg.resource_group_location
  nsg_name            = "main-nsg"
  vnet_address_space  = "10.0.0.0/16"
}

module "create_builder_nsg" {
  source              = "./modules/nsg"
  resource_group_name = module.build_agent_rg.resource_group_name
  location            = module.build_agent_rg.resource_group_location
  nsg_name            = "agent-nsg"
  vnet_address_space  = "10.1.0.0/16"
}

# Main VM
module "main_instance" {
  source              = "./modules/compute/main_instance"
  resource_group_name = module.main_instance_rg.resource_group_name
  location            = module.main_instance_rg.resource_group_location
  vm_name             = var.main_vm_name
  vm_size             = var.main_instance_vm_size
  admin_username      = var.vm_admin_username
  vm_private_ip       = var.vm_private_ip
  ssh_public_key      = data.doppler_secrets.az-creds.map.SSHPUB
  vm_sku              = var.vm_sku
  nsg_id              = module.create_main_nsg.nsg_id
}

# Build-Agent VM
module "build_agent_instance" {
  source              = "./modules/compute/build_agent_instance"
  resource_group_name = module.build_agent_rg.resource_group_name
  location            = module.build_agent_rg.resource_group_location
  vm_name             = "build-ub"
  vm_size             = var.build_agent_vm_size
  admin_username      = var.vm_admin_username
  ssh_public_key      = data.doppler_secrets.az-creds.map.SSHPUB
  instance_count      = var.instance_count
  vm_sku              = var.vm_sku
  nsg_id              = module.create_builder_nsg.nsg_id
}

# Module to block SSH access (deny)
module "main_rule_block_ssh" {
  source              = "./modules/nsg_rule"
  resource_group_name = module.main_instance_rg.resource_group_name
  nsg_name            = module.create_main_nsg.nsg_name
  priority            = 150
}

module "agent_rule_block_ssh" {
  source              = "./modules/nsg_rule"
  resource_group_name = module.build_agent_rg.resource_group_name
  nsg_name            = module.create_builder_nsg.nsg_name
  priority            = 150
}

# AKS cluster
module "aks_cluster" {
  source                  = "./modules/aks"
  resource_group_name     = module.aks_cluster_rg.resource_group_name
  resource_group_location = module.aks_cluster_rg.resource_group_location
  aks_vm_size             = var.aks_vm_size
  aks_node_count          = var.node_count
  aks_admin_username      = var.aks_admin_username
  ssh_public_key_data     = data.doppler_secrets.az-creds.map.SSHPUB
}

# Storage Account for backups
module "backup_storage" {
  source                = "./modules/backup_storage"
  resource_group_name   = module.backup_storage_rg.resource_group_name
  location              = module.backup_storage_rg.resource_group_location
  backup_storage_prefix = var.backup_storage_prefix
  container_name        = "backups"
}

# Ansible Inventory
module "ansible_inventory" {
  source           = "./modules/ansible_inventory"
  main_instance_ip = module.main_instance.public_ip
  build_agent_ips  = module.build_agent_instance.public_ips
  admin_username   = var.vm_admin_username
  inventory_path   = "../An/hosts"
}