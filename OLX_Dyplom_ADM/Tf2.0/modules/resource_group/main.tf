# modules/resource_group/main.tf

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

variable "azure_region" { type = string }

variable "resource_group_name" { type = string }

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.azure_region
}

output "resource_group_name" { value = azurerm_resource_group.this.name }

output "resource_group_location" { value = azurerm_resource_group.this.location}