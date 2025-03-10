terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    doppler = {
      source  = "DopplerHQ/doppler"
      version = "~> 1.2"
    }
    time = {
      source = "hashicorp/time"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4.0" 
    }
  }
}

provider "azurerm" {
  features {}
  
  use_cli = false
  subscription_id = data.doppler_secrets.az-creds.map.ARM_SUBSCRIPTION_ID
  client_id       = data.doppler_secrets.az-creds.map.ARM_CLIENT_ID
  client_secret   = data.doppler_secrets.az-creds.map.ARM_CLIENT_SECRET
  tenant_id       = data.doppler_secrets.az-creds.map.ARM_TENANT_ID
}

provider "cloudflare" {
  api_token = data.doppler_secrets.az-creds.map.CLOUDFLARE_API_TOKEN
}

data "doppler_secrets" "az-creds" {}

provider "doppler" {
  doppler_token = var.DOPPLER_AUTH_TOKEN
}