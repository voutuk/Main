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

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate)
  }
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