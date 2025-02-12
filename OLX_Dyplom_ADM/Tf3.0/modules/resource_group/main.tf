# modules/resource_group/main.tf

# INFO: Resource Group Variables
variable "azure_region" {
  type = string
}

variable "resource_group_name" {
  type = string
}

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.azure_region
}

# INFO: Resource Group Outputs
output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

output "resource_group_location" {
  value = azurerm_resource_group.this.location
}