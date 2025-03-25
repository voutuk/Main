resource "azurerm_storage_share" "jenkins_data" {
  name                 = "jenkins-data"
  storage_account_name = var.storage_account_name
  quota                = var.storage_quota
}

resource "azurerm_container_group" "jenkins" {
  name                = var.container_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Private"
  subnet_ids          = [var.subnet_id]
  os_type             = "Linux"
  restart_policy      = "Always"
  tags                = var.tags
  
  # Використовуємо базову SKU для економії коштів
  sku                 = "Standard"

  container {
    name   = "jenkins"
    image  = "mirror.gcr.io/jenkins/jenkins:lts-alpine-jdk17"
    cpu    = var.jenkins_cpu
    memory = var.jenkins_memory

    environment_variables = {
      "JENKINS_OPTS" = "--prefix=/jenkins"
      # Додамо опцію для зменшення використання пам'яті
      "JAVA_OPTS"    = "-Xmx1536m -Xms512m"
    }

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
  }

  container {
    name    = "cloudflare-warp"
    image   = "mirror.gcr.io/cloudflare/cloudflared:latest"
    cpu     = 0.2
    memory  = 0.2
    
    environment_variables = {
      "TUNNEL_LOGLEVEL" = "info"
      "TUNNEL_METRICS"  = "0.0.0.0:2000"
    }

    secure_environment_variables = {
      "TUNNEL_TOKEN" = var.cloudflare_tunnel_token
    }

    commands = [
      "cloudflared",
      "tunnel",
      "--no-autoupdate",
      "run",
      "--token",
      var.cloudflare_tunnel_token,
    ]
  }
}