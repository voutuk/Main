output "ingress_controller_ip" {
  description = "The IP address of the Ingress Controller"
  value       = local.ingress_controller_ip
}

output "frontdoor_endpoint_hostname" {
  description = "The hostname of the Front Door endpoint"
  value       = azurerm_cdn_frontdoor_endpoint.main.host_name
}

output "custom_domain_validation_token" {
  description = "The token for validating custom domain ownership"
  value       = azurerm_cdn_frontdoor_custom_domain.main.validation_token
}

output "dns_name_servers" {
  description = "The name servers for the DNS zone"
  value       = azurerm_dns_zone.main.name_servers
}