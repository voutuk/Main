# Створення мережевої інфраструктури
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  
  tags = {
    environment = "production"
    application = "gosell"
  }
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefix
}

# Створення AKS кластера
resource "azurerm_kubernetes_cluster" "cluster" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                = "system"
    vm_size             = "Standard_B2s"
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 3
    vnet_subnet_id      = azurerm_subnet.aks_subnet.id
    os_disk_size_gb     = 30
    node_labels = {
      "nodepool-type" = "system"
      "environment"   = "production"
    }
    node_taints = ["CriticalAddonsOnly=true:NoSchedule"]
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_policy    = "calico"
  }

  dynamic "oms_agent" {
    for_each = var.log_analytics_workspace_id != null ? [1] : []
    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  tags = {
    environment = "production"
    application = "gosell"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "app_pool" {
  name                  = "apppool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.cluster.id
  vm_size               = "Standard_D4s_v3"
  enable_auto_scaling   = true
  min_count             = 2
  max_count             = 5
  vnet_subnet_id        = azurerm_subnet.aks_subnet.id
  os_disk_size_gb       = 120
  node_labels = {
    "nodepool-type" = "application"
    "environment"   = "production"
    "app"           = "gosell"
  }
  
  tags = {
    environment = "production"
    application = "gosell"
  }
}