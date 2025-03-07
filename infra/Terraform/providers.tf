# MAIN providers.tf

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    doppler = {
      source = "DopplerHQ/doppler"
    }
    time = {
      source = "hashicorp/time"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
  client_id       = data.doppler_secrets.az-creds.map.CLIENT_ID
  client_secret   = data.doppler_secrets.az-creds.map.CLIENT_SECRET
  tenant_id       = data.doppler_secrets.az-creds.map.TENANT_ID
}

data "doppler_secrets" "az-creds" {}

provider "doppler" {
  doppler_token = var.doppler_token
}