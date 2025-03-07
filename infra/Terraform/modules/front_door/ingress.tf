# Створення публічної IP-адреси для Ingress Controller
resource "azurerm_public_ip" "ingress_ip" {
  name                = "ingress-public-ip"
  resource_group_name = var.node_resource_group_name # Використовуємо resource group вузлів AKS
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# Встановлення Ingress Controller з вказаною IP-адресою
resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.7.1"  # Вкажіть актуальну версію
  namespace        = "ingress-nginx"
  create_namespace = true

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
  
  set {
    name  = "controller.service.loadBalancerIP"
    value = azurerm_public_ip.ingress_ip.ip_address
  }
  
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-resource-group"
    value = var.node_resource_group_name
  }

  # Додаткові налаштування Ingress Controller
  set {
    name  = "controller.replicaCount"
    value = "2"
  }
  
  set {
    name  = "controller.metrics.enabled"
    value = "true"
  }
  
  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }
}

# Локальна змінна з IP-адресою для Front Door
locals {
  ingress_controller_ip = azurerm_public_ip.ingress_ip.ip_address
}