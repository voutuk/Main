# Front Door Standard профіль
resource "azurerm_cdn_frontdoor_profile" "main" {
  name                = var.front_door_name
  resource_group_name = var.resource_group_name
  sku_name            = var.front_door_sku
  tags                = var.tags
}

# Front Door кінцева точка
resource "azurerm_cdn_frontdoor_endpoint" "main" {
  name                     = "default"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.main.id
  tags                     = var.tags
}

# Група походження
resource "azurerm_cdn_frontdoor_origin_group" "main" {
  name                     = "default-origin-group"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.main.id
  load_balancing {
    sample_size                 = 4
    successful_samples_required = 3
  }

  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }
}

# Походження (Origin) вказуючи на IP ingress controller
resource "azurerm_cdn_frontdoor_origin" "main" {
  name                           = "ingress-origin"
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.main.id
  enabled                        = true
  certificate_name_check_enabled = true

  host_name          = local.ingress_controller_ip  # IP-адреса ingress controller
  http_port          = 80
  https_port         = 443
  origin_host_header = var.domain_name
  priority           = 1
  weight             = 1000
}

# Маршрут для дефолтного домену
resource "azurerm_cdn_frontdoor_route" "main" {
  name                          = "default-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.main.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.main.id
  enabled                       = true
  
  forwarding_protocol    = "HttpsOnly"
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]
  cdn_frontdoor_origin_ids = [azurerm_cdn_frontdoor_origin.main.id]

  link_to_default_domain = true
}

# Налаштування власного домену
resource "azurerm_cdn_frontdoor_custom_domain" "main" {
  name                     = "custom-domain"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.main.id
  dns_zone_id              = azurerm_dns_zone.main.id
  host_name                = var.domain_name

  tls {
    certificate_type    = "ManagedCertificate"
    minimum_tls_version = "TLS12"
  }
}

# Маршрут для власного домену
resource "azurerm_cdn_frontdoor_route" "custom_domain" {
  name                          = "custom-domain-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.main.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.main.id
  enabled                       = true
  
  forwarding_protocol           = "HttpsOnly"
  patterns_to_match             = ["/*"]
  supported_protocols           = ["Http", "Https"]
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.main.id]
  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.main.id]
}