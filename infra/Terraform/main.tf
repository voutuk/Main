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
module "storage_rg" {
  source              = "./modules/resource_group"
  resource_group_name = "${var.rg_prefix}-storage"
  location            = var.dev_locate
  tags                = var.tags
}

module "aks_cluster_rg" {
  source              = "./modules/resource_group"
  resource_group_name = "${var.rg_prefix}-aks-cluster"
  location            = var.prod_locate
  tags                = var.tags
}

module "vvms_instance_rg" {
  source              = "./modules/resource_group"
  resource_group_name = "${var.rg_prefix}-build-agents"
  location            = var.dev_locate
  tags                = var.tags
}

module "container_rg" {
  source              = "./modules/resource_group"
  resource_group_name = "${var.rg_prefix}-main"
  location            = var.dev_locate
  tags                = var.tags
}

# Network Security Group
module "create_vvms_nsg" {
  source              = "./modules/nsg"
  resource_group_name = module.vvms_instance_rg.resource_group_name
  location            = module.vvms_instance_rg.resource_group_location
  nsg_name            = "vvms-nsg"
  vnet_address_space  = "10.2.0.0/16"  #FIXME
  tags                = var.tags
}

# Main VM
module "container_instance" {
  source                  = "./modules/compute/container_instance"
  resource_group_name     = module.container_rg.resource_group_name
  location                = module.container_rg.resource_group_location
  container_name          = "jenkins"
  jenkins_image           = "mirror.gcr.io/jenkins/jenkins:lts"
  doppler_auth            = var.DOPPLER_AUTH_TOKEN
  cloudflare_tunnel_token = data.doppler_secrets.az-creds.map.CLOUDFLARE_TUNNEL_TOKEN
  storage_account_name    = module.storage_account.storage_account_name
  storage_account_key     = module.storage_account.account_key
  docker_hub_password     = var.docker_hub_username
  docker_hub_username     = data.doppler_secrets.az-creds.map.DOCKERHUB_KEY
  tags                    = var.tags
}

# Build-Agent VM
module "vvms_instance" {
  source                = "./modules/compute/vvms"
  resource_group_name   = module.vvms_instance_rg.resource_group_name
  location              = module.vvms_instance_rg.resource_group_location
  ssh_public_key        = data.doppler_secrets.az-creds.map.SSHPUB
  cloudflare_zone_id    = data.doppler_secrets.az-creds.map.CLOUDFLARE_ZONE_ID
  # cloudflare_account_id = data.doppler_secrets.az-creds.map.CLOUDFLARE_ACCOUNT_ID
  network_security_group_name = module.create_vvms_nsg.nsg_name
  nsg_id                = module.create_vvms_nsg.nsg_id
  vm_sku                = var.vvms_sku
  sku                   = var.sku
  vmss_name             = var.vmss_name
  instance_count        = var.instance_count
  admin_username        = var.vm_admin_username
  vnet_address_space    = var.vvms_vnet_address_space
  subnet_address_space  = var.vvms_subnet_address_space
  tags                  = var.tags
}

module "vvms_rule_block_ssh" {
  source              = "./modules/nsg_rule"
  resource_group_name = module.vvms_instance_rg.resource_group_name
  nsg_name            = module.create_vvms_nsg.nsg_name
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
  vnet_address_space      = var.ask_address_space
  subnet_address_prefix   = var.ask_subnet_address_prefix
  # Add system node pool configuration
  system_node_count       = 1
  system_min_node_count   = 1
  system_max_node_count   = 2
}

# Storage Account 
module "storage_account" {
  source                = "./modules/storage"
  resource_group_name   = module.storage_rg.resource_group_name
  location              = module.storage_rg.resource_group_location
  storage_prefix        = var.storage_prefix
  container_name        = "storage-container"
  tags                  = var.tags
}