# GitHub: https://github.com/voutuk/main
# License: Academic Free License ("AFL") v. 3.0
#
# Purpose: This Terraform configuration deploys a development instance 
#          with 2 build-agent VMs, 1 main VM, 1 NSG, and an NSG rule.
# Prerequisites: A Doppler .env secret key.
# Variables: ./variables.tf
#
# Azure Provider: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
# Azure API Provider: https://registry.terraform.io/providers/azure/azapi/latest/docs
# Doppler Provider: https://registry.terraform.io/providers/DopplerHQ/doppler/latest/docs

# Resource Groups for different components
module "backup_storage_rg" {
  source              = "./modules/resource_group"
  resource_group_name = "${var.rg_prefix}-backup-storage"
  location            = "westeurope"  # You can change this region
  tags                = var.tags
}

module "aks_cluster_rg" {
  source              = "./modules/resource_group"
  resource_group_name = "gosell-aks-cluster"
  location            = "northeurope"  # You can change this region
  tags                = var.tags
}

module "main_instance_rg" {
  source              = "./modules/resource_group"
  resource_group_name = "${var.rg_prefix}-main-instance"
  location            = "westus"  # You can change this region
  tags                = var.tags
}

module "build_agent_rg" {
  source              = "./modules/resource_group"
  resource_group_name = "${var.rg_prefix}-build-agents"
  location            = "eastus"  # You can change this region
  tags                = var.tags
}

# Network Security Group
module "create_main_nsg" {
  source              = "./modules/nsg"
  resource_group_name = module.main_instance_rg.resource_group_name
  location            = module.main_instance_rg.resource_group_location
  nsg_name            = "main-nsg"
  vnet_address_space  = "10.0.0.0/16"
  tags                = var.tags
}

module "create_builder_nsg" {
  source              = "./modules/nsg"
  resource_group_name = module.build_agent_rg.resource_group_name
  location            = module.build_agent_rg.resource_group_location
  nsg_name            = "agent-nsg"
  vnet_address_space  = "10.1.0.0/16"
  tags                = var.tags
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
  tags                = var.tags
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
  tags                = var.tags
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

# AKS cluster module
module "aks_cluster" {
  source                  = "./modules/aks"
  resource_group_name     = module.aks_cluster_rg.resource_group_name
  location                = module.aks_cluster_rg.resource_group_location
  cluster_name            = var.aks_name
  dns_prefix              = var.dns_prefix
  kubernetes_version      = "1.30.9"
  vnet_name               = var.vnet_name
  subnet_name             = var.subnet_name
  tags                    = var.tags
  vnet_address_space      = var.address_space
  subnet_address_prefix   = var.subnet_address_prefix
  # Add system node pool configuration
  system_node_count       = 1
  system_min_node_count   = 1
  system_max_node_count   = 2
}


module "front_door" {
  source              = "./modules/front_door"
  resource_group_name = module.aks_cluster_rg.resource_group_name
  front_door_name     = var.front_door_name
  backend_host_header = module.aks_cluster.fqdn
  backend_address     = module.aks_cluster.fqdn
  tags                = var.tags
}

module "ingress" {
  source                  = "./modules/ingress"
  kubernetes_cluster_name = module.aks_cluster.name
}

# Storage Account for backups
module "backup_storage" {
  source                = "./modules/backup_storage"
  resource_group_name   = module.backup_storage_rg.resource_group_name
  location              = module.backup_storage_rg.resource_group_location
  backup_storage_prefix = var.backup_storage_prefix
  container_name        = "backups"
  tags                  = var.tags
}

# Ansible Inventory
module "ansible_inventory" {
  source           = "./modules/ansible_inventory"
  main_instance_ip = module.main_instance.public_ip
  build_agent_ips  = module.build_agent_instance.public_ips
  admin_username   = var.vm_admin_username
  inventory_path   = "../Ansible/hosts"
}