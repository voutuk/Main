# modules/aks/main.tf

# INFO: Variables for AKS
variable "ssh_public_key_data" {
  type        = string
  description = "Public SSH key data used by the AKS cluster"
}

variable "aks_admin_username" {
  type        = string
  description = "Admin username for the AKS cluster"
}

variable "aks_resource_group_name_prefix" {
  type        = string
  description = "Prefix for the AKS resource group name to ensure uniqueness"
}

variable "aks_resource_group_location" {
  type        = string
  description = "Location where the AKS resource group will be created"
}

variable "aks_node_count" {
  type        = number
  description = "Number of nodes in the default AKS node pool"
}

variable "aks_vm_size" {
  type        = string
  description = "Size of the VMs in the AKS node pool"
}

# Generates a name for the AKS resource group
resource "random_pet" "rg_name" {
  prefix = var.aks_resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.aks_resource_group_location
  name     = random_pet.rg_name.id
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
  location            = azurerm_resource_group.rg.location
  name                = random_pet.azurerm_kubernetes_cluster_name.id
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = random_pet.azurerm_kubernetes_cluster_dns_prefix.id

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