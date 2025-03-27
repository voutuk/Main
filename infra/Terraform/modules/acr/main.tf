# Azure Container Registry Resource
resource "azurerm_container_registry" "acr" {
  name                = local.sanitized_storage_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
  tags                = var.tags
}

# Optional: Assign AcrPull role to additional identities if provided
resource "azurerm_role_assignment" "acr_pull" {
  count                = length(var.pull_principal_ids)
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = var.pull_principal_ids[count.index]
}

# Generate Jenkinsfile from template
locals {
  template_path = "${path.module}/Jenkinsfile.push.tpl"
}

resource "local_file" "jenkinsfile" {
  content = templatefile(local.template_path, {
    ACR_NAME = azurerm_container_registry.acr.name
    RESOURCE_GROUP_NAME = azurerm_container_registry.acr.resource_group_name
    tags = var.tags
  })
  filename = var.jenkinsfile_path
}

resource "random_pet" "as_storage_name" {
  prefix    = var.acr_name
  separator = ""
}

locals {
  # Remove invalid characters and limit length to 24
  cleaned_name          = join("", regexall("[a-z0-9]", lower(random_pet.as_storage_name.id)))
  sanitized_storage_name = substr(local.cleaned_name, 0, 24)
}

resource "doppler_secret" "azure_container_registry" {
  project = "az"
  config  = "dev"
  name    = "AZURE_CONTAINER_REGISTRY"
  value   = azurerm_container_registry.acr.name
}