# File Share for Jenkins data
resource "azurerm_storage_share" "jenkins_data" {
  name                 = "jenkins-data"
  storage_account_name = var.storage_account_name
  quota                = 50
}

# Container Instance with WARP sidecar in VNet
resource "azurerm_container_group" "jenkins" {
  name                = var.container_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Private"
  os_type             = "Linux"
  tags                = var.tags
  subnet_ids          = [var.subnet_id]
  
  # Jenkins Container
  container {
    name   = "jenkins"
    image  = var.jenkins_image
    cpu    = var.cpu
    memory = var.memory

    ports {
      port     = 8080
      protocol = "TCP"
    }

    ports {
      port     = 50000
      protocol = "TCP"
    }

    volume {
      name                 = "jenkins-home"
      mount_path           = "/var/jenkins_home"
      storage_account_name = var.storage_account_name
      storage_account_key  = var.storage_account_key
      share_name           = azurerm_storage_share.jenkins_data.name
    }

    environment_variables = {
      "JENKINS_OPTS" = "--prefix=/jenkins"
    }
    secure_environment_variables = {
      "DOPPLER_TOKEN" = var.doppler_auth
    }
  }
  
  # Cloudflare WARP sidecar container
  container {
    name   = "cloudflare-warp"
    image  = "mirror.gcr.io/cloudflare/cloudflared:latest"
    cpu    = 0.5
    memory = 0.5
    
    # Command to start WARP in tunnel mode
    commands = [
      "cloudflared",
      "tunnel", 
      "--no-autoupdate", 
      "run", 
      "--token", 
      var.cloudflare_tunnel_token
    ]
    
    environment_variables = {
      "TUNNEL_METRICS"      = "0.0.0.0:2000", 
      "TUNNEL_LOGLEVEL"     = "info"
    }
    
    secure_environment_variables = {
      "TUNNEL_TOKEN" = var.cloudflare_tunnel_token
    }
  }
}