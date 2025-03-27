terraform {
  required_version = ">= 1.0.0"
  
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 3.0.0"
    }
  }
}

provider "kubernetes" {
  config_path    = var.kubernetes_config_path  # "~/.kube/config"
  config_context = var.kubernetes_context      # "your-cluster-context"
}