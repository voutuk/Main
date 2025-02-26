# INFO: Variables for AKS
variable "ssh_public_key_data" {
  type        = string
  description = "Public SSH key data used by the AKS cluster"
}

variable "aks_admin_username" {
  type        = string
  description = "Admin username for the AKS cluster"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where AKS will be created"
}

variable "resource_group_location" {
  type        = string
  description = "Location where the AKS cluster will be created"
}

variable "aks_node_count" {
  type        = number
  description = "Number of nodes in the default AKS node pool"
}

variable "aks_vm_size" {
  type        = string
  description = "Size of the VMs in the AKS node pool"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the AKS cluster"
  default     = {}
}

# Generates a name for the AKS cluster
resource "random_pet" "azurerm_kubernetes_cluster_name" {
  prefix = "cluster"
}

# Generates a DNS prefix for the AKS cluster
resource "random_pet" "azurerm_kubernetes_cluster_dns_prefix" {
  prefix = "dns"
}

# Creates the AKS cluster
resource "azurerm_kubernetes_cluster" "k8s" {
  location            = var.resource_group_location
  name                = random_pet.azurerm_kubernetes_cluster_name.id
  resource_group_name = var.resource_group_name
  dns_prefix          = random_pet.azurerm_kubernetes_cluster_dns_prefix.id
  tags                = var.tags

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = var.aks_vm_size
    node_count = var.aks_node_count
  }

  linux_profile {
    admin_username = var.aks_admin_username

    ssh_key {
      key_data = var.ssh_public_key_data
    }
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}