# Azure Container Instances for monitoring stack (Prometheus, Grafana, Loki)

# File share for Prometheus data
resource "azurerm_storage_share" "prometheus_data" {
  name                 = "prometheus-data"
  storage_account_name = var.storage_account_name
  quota                = 10
}

# File share for Grafana data
resource "azurerm_storage_share" "grafana_data" {
  name                 = "grafana-data"
  storage_account_name = var.storage_account_name
  quota                = 5
}

# File share for Loki data
resource "azurerm_storage_share" "loki_data" {
  name                 = "loki-data"
  storage_account_name = var.storage_account_name
  quota                = 10
}

# Container group for monitoring stack
resource "azurerm_container_group" "monitoring" {
  name                = "monitoring"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  ip_address_type     = "Private"
  tags                = var.tags
  subnet_ids          = [var.subnet_id]
  restart_policy      = "Always"

  # Prometheus container
  container {
    name   = "prometheus"
    image  = "mirror.gcr.io/prom/prometheus:latest"
    cpu    = "1.0"
    memory = "1.5"

    ports {
      port     = 9090
      protocol = "TCP"
    }

    volume {
      name                 = "prometheus-data"
      mount_path           = "/prometheus"
      storage_account_name = var.storage_account_name
      storage_account_key  = var.storage_account_key
      share_name           = azurerm_storage_share.prometheus_data.name
    }

    environment_variables = {
      "TZ" = "UTC"
    }
  }

  # Grafana container
  container {
    name   = "grafana"
    image  = "mirror.gcr.io/grafana/grafana:latest"
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 3000
      protocol = "TCP"
    }

    volume {
      name                 = "grafana-data"
      mount_path           = "/var/lib/grafana"
      storage_account_name = var.storage_account_name
      storage_account_key  = var.storage_account_key
      share_name           = azurerm_storage_share.grafana_data.name
    }

    environment_variables = {
      "GF_SECURITY_ADMIN_USER"     = var.grafana_admin_user
      "GF_SECURITY_ADMIN_PASSWORD" = var.grafana_admin_password
      "GF_INSTALL_PLUGINS"         = "grafana-clock-panel,grafana-simple-json-datasource"
      "GF_USERS_ALLOW_SIGN_UP"     = "false"
    }
  }

  # Loki container
  container {
    name   = "loki"
    image  = "mirror.gcr.io/grafana/loki:latest"
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 3100
      protocol = "TCP"
    }

    volume {
      name                 = "loki-data"
      mount_path           = "/loki"
      storage_account_name = var.storage_account_name
      storage_account_key  = var.storage_account_key
      share_name           = azurerm_storage_share.loki_data.name
    }
  }

}