output "kubernetes_cluster_id" {
  value = azurerm_kubernetes_cluster.cluster.id
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.cluster.name
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config_raw
  sensitive = true
}

output "host" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config.0.host
  sensitive = true
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate
  sensitive = true
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config.0.client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate
  sensitive = true
}

output "cluster_fqdn" {
  value = azurerm_kubernetes_cluster.cluster.fqdn
}

# Network outputs
output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  value = azurerm_subnet.aks_subnet.id
}