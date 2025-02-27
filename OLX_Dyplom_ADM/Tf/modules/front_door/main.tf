resource "azurerm_frontdoor" "front_door" {
  name                = var.front_door_name
  resource_group_name = var.resource_group_name
  tags                = var.tags

  routing_rule {
    name               = "gosell-routing-rule"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["gosell-frontend"]
    forwarding_configuration {
      forwarding_protocol = "HttpsOnly"
      backend_pool_name   = "goSellBackend"
    }
  }

  backend_pool_load_balancing {
    name = "goSellLoadBalancing"
  }

  backend_pool_health_probe {
    name                = "goSellHealthProbe"
    path                = "/healthz"
    protocol            = "Https"
    interval_in_seconds = 30
  }

  backend_pool {
    name = "goSellBackend"
    backend {
      host_header = var.backend_host_header
      address     = var.backend_address
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "goSellLoadBalancing"
    health_probe_name   = "goSellHealthProbe"
  }

  frontend_endpoint {
    name                 = "gosell-frontend"
    host_name            = "${var.front_door_name}.azurefd.net"
  }
}