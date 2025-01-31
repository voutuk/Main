terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    doppler = {
      source = "DopplerHQ/doppler"
    }
    time = {
      source = "hashicorp/time"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "doppler" {
  doppler_token = var.doppler_token
}

data "doppler_secrets" "az-creds" {}

provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
  client_id       = data.doppler_secrets.az-creds.map.CLIENT_ID
  client_secret   = data.doppler_secrets.az-creds.map.CLIENT_SECRET
  tenant_id       = data.doppler_secrets.az-creds.map.TENANT_ID
}