
variable "ssh_public_key_data" { type = string }
variable "username" { type = string }
variable "resource_group_name_prefix" { type = string }
variable "resource_group_location" { type = string }
variable "node_count" { type = number }
variable "vm_size" { type = string }

# random_pet to generate Resource Group name
resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

# random_pet for cluster name
resource "random_pet" "azurerm_kubernetes_cluster_name" {
  prefix = "cluster"
}

# random_pet for dns prefix
resource "random_pet" "azurerm_kubernetes_cluster_dns_prefix" {
  prefix = "dns"
}

# Create AKS
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
    vm_size    = var.vm_size
    node_count = var.node_count
  }

  linux_profile {
    admin_username = var.username

    ssh_key {
      # This references the key generated in ssh.tf; you might integrate it here or pass via variables
      key_data = var.ssh_public_key_data  # pass as variable if the SSH resource is outside
    }
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}