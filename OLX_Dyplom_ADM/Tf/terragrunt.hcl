# Root terragrunt.hcl

# Generate providers configuration
generate "providers" {
  path      = "generated_providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
  client_id       = data.doppler_secrets.az-creds.map.CLIENT_ID
  client_secret   = data.doppler_secrets.az-creds.map.CLIENT_SECRET
  tenant_id       = data.doppler_secrets.az-creds.map.TENANT_ID
}

provider "doppler" {
  doppler_token = var.doppler_token
}

provider "azapi" {
  subscription_id = var.azure_subscription_id
  client_id       = data.doppler_secrets.az-creds.map.CLIENT_ID
  client_secret   = data.doppler_secrets.az-creds.map.CLIENT_SECRET
  tenant_id       = data.doppler_secrets.az-creds.map.TENANT_ID
}

provider "time" {}
provider "random" {}
provider "local" {}
EOF
}

# Налаштування глобальних значень для всіх модулів
locals {
  project     = "GoSell"
  owner       = "voutuk"
  
  # Базові теги, які будуть застосовані до всіх ресурсів
  common_tags = {
    Project     = local.project
    Owner       = local.owner
    ManagedBy   = "terragrunt"
    CreatedAt   = timestamp()
  }
}

# Global variables that can be referenced in child configurations
inputs = {
  doppler_token = get_env("DOPPLER_TOKEN")
  tags          = local.common_tags
}