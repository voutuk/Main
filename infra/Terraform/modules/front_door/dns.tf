# Публічна DNS зона
resource "azurerm_dns_zone" "main" {
  name                = var.domain_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# CNAME запис для Front Door
resource "azurerm_dns_cname_record" "main" {
  name                = "@"
  zone_name           = azurerm_dns_zone.main.name
  resource_group_name = var.resource_group_name
  ttl                 = 3600
  record              = azurerm_cdn_frontdoor_endpoint.main.host_name
  tags                = var.tags
}

# TXT запис для валідації домену
resource "azurerm_dns_txt_record" "frontdoor_validation" {
  name                = "_dnsauth"
  zone_name           = azurerm_dns_zone.main.name
  resource_group_name = var.resource_group_name
  ttl                 = 3600
  tags                = var.tags
  
  record {
    value = azurerm_cdn_frontdoor_custom_domain.main.validation_token
  }
}

# Додайте запис для www піддомену, якщо потрібно
resource "azurerm_dns_cname_record" "www" {
  name                = "www"
  zone_name           = azurerm_dns_zone.main.name
  resource_group_name = var.resource_group_name
  ttl                 = 3600
  record              = azurerm_cdn_frontdoor_endpoint.main.host_name
  tags                = var.tags
}