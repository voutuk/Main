
# File Share for Jenkins data
resource "azurerm_storage_share" "jenkins_data" {
  name                 = "jenkins-data"
  storage_account_name = var.storage_account_name
  quota                = 50
}

# Container Instance with WARP sidecar
resource "azurerm_container_group" "jenkins" {
  name                = var.container_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  dns_name_label      = var.dns_name_label
  os_type             = "Linux"
  tags                = var.tags
  
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
  }
  # Cloudflare WARP sidecar container
  container {
    name   = "cloudflare-warp"
    image  = "mirror.gcr.io/cloudflare/cloudflared:latest"
    cpu    = 1
    memory = 1
    
    # Command to start WARP in tunnel mode
    commands = [
      "cloudflared",  # Ім'я виконуваного файлу
      "tunnel", 
      "--no-autoupdate", 
      "run", 
      "--token", 
      var.cloudflare_tunnel_token
    ]
    
    # Mount shared volume for tunnel credentials
    volume {
      name       = "cloudflare-config"
      mount_path = "/etc/cloudflared"
      empty_dir  = true
    }
    
    # Environment variables for Cloudflare configuration
    environment_variables = {
      "TUNNEL_METRICS"      = "0.0.0.0:2000", 
      "TUNNEL_LOGLEVEL"     = "info"
    }
    
    secure_environment_variables = {
      "TUNNEL_TOKEN" = var.cloudflare_tunnel_token
    }
  }
}

# Network Security Group for Jenkins
resource "azurerm_network_security_group" "jenkins" {
  name                = "jenkins-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  security_rule {
    name                       = "allow-jenkins-web"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-jenkins-agent"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "50000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}