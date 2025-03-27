# modules/aks/outputs.tf

output "id" {
  description = "The Kubernetes Managed Cluster ID"
  value       = azurerm_kubernetes_cluster.cluster.id
}

output "name" {
  description = "The name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.cluster.name
}

output "host" {
  description = "The Kubernetes cluster server host"
  value       = azurerm_kubernetes_cluster.cluster.kube_config.0.host
}

output "client_certificate" {
  description = "Base64 encoded certificate for authentication"
  value       = azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate
}

output "client_key" {
  description = "Base64 encoded key for authentication"
  value       = azurerm_kubernetes_cluster.cluster.kube_config.0.client_key
}

output "ca_certificate" {
  description = "Base64 encoded CA certificate"
  value       = azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate
}

output "kube_config_raw" {
  description = "Raw kube config"
  value       = azurerm_kubernetes_cluster.cluster.kube_config_raw
  sensitive   = true
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = var.resource_group_name
}

output "fqdn" {
  description = "The FQDN of the Azure Kubernetes Managed Cluster"
  value       = azurerm_kubernetes_cluster.cluster.fqdn
}

output "node_resource_group" {
  description = "The resource group where AKS nodes are deployed"
  value       = azurerm_kubernetes_cluster.cluster.node_resource_group
}

output "kubernetes_version" {
  description = "The version of Kubernetes"
  value       = azurerm_kubernetes_cluster.cluster.kubernetes_version
}

output "principal_id" {
  description = "The principal ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.cluster.identity[0].principal_id
}