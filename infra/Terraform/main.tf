# GitHub: https://github.com/voutuk/main
# License: Academic Free License ("AFL") v. 3.0
#
# Purpose: This Terraform configuration deploys a development instance 
#   of Jenkins CI, an AKS cluster, and a storage account.
# Prerequisites: yarn run pre
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

module "aks_rg" {
  source              = "./modules/resource_group"
  resource_group_name = "${var.rg_prefix}-aks-cluster"
  location            = var.prod_locate
  tags                = var.tags
}

module "instance_rg" {
  source              = "./modules/resource_group"
  resource_group_name = "${var.rg_prefix}-instance"
  location            = var.dev_locate
  tags                = var.tags
}

module "network" {
  source                  = "./modules/instance/net"
  base_name               = "minimal"
  resource_group_name     = module.instance_rg.name
  location                = module.instance_rg.location
  vnet_address_space      = ["10.0.0.0/16"]
  ci_subnet_address_space = ["10.0.1.0/24"]
  tags                    = var.tags
}

# Jenkins CI
module "ci" {
  source                  = "./modules/instance/ci"
  container_name          = "jenkins"
  resource_group_name     = module.instance_rg.name
  location                = module.instance_rg.location
  storage_account_name    = module.sa.account_name
  storage_account_key     = module.sa.account_key
  doppler_auth            = data.doppler_secrets.az-creds.map.TF_VAR_DOPPLER_AUTH_TOKEN
  cloudflare_tunnel_token = data.doppler_secrets.az-creds.map.CLOUDFLARE_TUNNEL_TOKEN
  subnet_id               = module.network.ci_subnet_id
  jenkins_cpu             = 1
  jenkins_memory          = 2
  storage_quota           = 20
  tags                    = var.tags
}

# AKS cluster module
module "aks_cluster" {
  source                  = "./modules/aks"
  resource_group_name     = module.aks_rg.name
  location                = module.aks_rg.location
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
module "sa" {
  source                = "./modules/storage"
  resource_group_name   = module.storage_rg.name
  location              = module.storage_rg.location
  storage_prefix        = var.storage_prefix
  container_name        = "storage-container"
  tags                  = var.tags
}