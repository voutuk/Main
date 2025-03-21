# modules/aks/main.tf


resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefix
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                = "default"
    node_count          = var.node_count
    vm_size             = var.vm_size
    vnet_subnet_id      = azurerm_subnet.aks_subnet.id
    enable_auto_scaling = var.enable_auto_scaling
    min_count           = var.min_node_count
    max_count           = var.max_node_count
    # Removed node_taints line which was causing the error
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    load_balancer_sku  = "standard"
    service_cidr       = "172.16.0.0/16"  # Changed to non-overlapping range
    dns_service_ip     = "172.16.0.10"    # Must be within service_cidr range
    # docker_bridge_cidr = "172.17.0.1/16"  # Non-overlapping with both subnet and service CIDR
  }

  role_based_access_control_enabled = true
  tags = var.tags
}

# Added separate system node pool with taints
resource "azurerm_kubernetes_cluster_node_pool" "system" {
  name                  = "system"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.cluster.id
  vm_size               = var.vm_size
  node_count            = var.system_node_count
  mode                  = "System"
  node_taints           = ["CriticalAddonsOnly=true:NoSchedule"]
  
  vnet_subnet_id        = azurerm_subnet.aks_subnet.id
  enable_auto_scaling   = var.enable_auto_scaling
  min_count             = var.system_min_node_count
  max_count             = var.system_max_node_count
}

resource "doppler_secret" "principal_id_aks" {
  project = "az"
  config  = "dev"
  name    = "PRINCIPAL_ID"
  value   = azurerm_kubernetes_cluster.cluster.identity[0].principal_id
}