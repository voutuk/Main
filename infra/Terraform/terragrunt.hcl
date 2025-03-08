# Root terragrunt configuration
locals {
  project = "GoSell"
  common_tags = {
    Project   = local.project
    Owner     = get_env("OWNER_EMAIL", "voutuk@icloud.com")
    ManagedBy = "terragrunt"
    CreatedAt = timestamp()
  }
}

# Remote state configuration
remote_state {
  backend = "azurerm"
  config = {
    resource_group_name  = get_env("AZURE_CONTAINER_RESOURCE_GROUP")
    storage_account_name = get_env("AZURE_STORAGE_ACCOUNT")
    container_name       = get_env("AZURE_CONTAINER_NAME")
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    
    client_id            = get_env("ARM_CLIENT_ID")
    client_secret        = get_env("ARM_CLIENT_SECRET")
    tenant_id            = get_env("ARM_TENANT_ID")
    subscription_id      = get_env("ARM_SUBSCRIPTION_ID")
    use_azuread_auth     = false
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  
}

inputs = {
  tags = local.common_tags
}

terraform {
  after_hook "cleanup_backend" {
    commands = ["apply", "plan", "destroy", "init", "validate"]
    execute  = ["rm", "-f", "backend.tf"]
  }
}