# GitHub: https://github.com/voutuk/main
# License: MIT License with Non-Commercial Use Restriction
#
# Purpose: This Terraform configuration deploys a development instance 
# 2 vm's (build-agent), 1 vm (main_instance), 1 nsg and rule.
# Prerequisites: ** .env doppler secret key ** Azure subscription_id, client_id, client_secret, tenant_id
# Variables: ./variables.tf
#
# Azure Provider: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
#
# terraform apply -target=module.resource_group -auto-approve
# terraform apply -target=module.create_nsg -auto-approve
# terraform apply -target=module.main_instance -auto-approve
# terraform apply -target=module.build_agent_instance -auto-approve
# terraform apply -target=module.rule_block_ssh -auto-approve
# az vm show -d -g dev-environment-rg -n dev-vm --query "publicIps" -o tsv


terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"  // Azure provider
      version = "~> 3.0"
    }
    doppler = {
      source = "DopplerHQ/doppler"  // Doppler provider
    }
    time = {
      source = "hashicorp/time"   // Time provider
    }
  }
}

variable "doppler_token" { // Doppler token key
  sensitive   = true
  type        = string
  description = "Doppler token"
}
provider "doppler" {
  doppler_token = var.doppler_token
}
data "doppler_secrets" "az-creds" {}


provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
  client_id       = data.doppler_secrets.az-creds.map.APPID       // Get secrets from Doppler
  client_secret   = data.doppler_secrets.az-creds.map.PASSWORD
  tenant_id       = data.doppler_secrets.az-creds.map.TENANT
}

###################################################################
# Create resource-group (step-1):
###################################################################
module "resource_group" {
  source              = "./modules/resource_group"
  azure_region        = var.azure_region
  resource_group_name = var.resource_group_name
}

###################################################################
# Main vm (step - 3):
###################################################################
module "main_instance" {
  source              = "./modules/compute/main_instance"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  vm_name             = var.main_vm_name
  vm_size             = var.main_instance_vm_size
  admin_username      = var.vm_admin_username
  vm_private_ip       = var.vm_private_ip
  ssh_public_key      = data.doppler_secrets.az-creds.map.SSHPUB   #file("./azure_rsa.pub")
  vm_sku              = var.vm_sku
  nsg_id              = module.create_nsg.nsg_id
}

###################################################################
# Build-Agent vm`s (step - 4):
###################################################################
module "build_agent_instance" {
  source              = "./modules/compute/build_agent_instance"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  vm_name             = "build-ub"
  subnet_id           = module.main_instance.subnet_id
  vm_size             = var.build_agent_vm_size
  admin_username      = var.vm_admin_username
  ssh_public_key      = data.doppler_secrets.az-creds.map.SSHPUB   #file("./azure_rsa.pub")
  instance_count      = var.instance_count
  vm_sku              = var.vm_sku
  nsg_id              = module.create_nsg.nsg_id
}

###################################################################
# Create rule block ssh port nsg (step - 5):
###################################################################
module "rule_block_ssh" {
  source              = "./modules/nsg_rule"
  resource_group_name = module.resource_group.resource_group_name
  nsg_name            = "vm-nsg"
  priority            = 150      // Main priority 200
  depends_on          = [module.create_nsg]
}

###################################################################
# Create NSG (step - 2):
###################################################################
module "create_nsg" {
  source              = "./modules/nsg"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  nsg_name            = "vm-nsg"
  vnet_address_space  = "10.0.0.0/16"
}