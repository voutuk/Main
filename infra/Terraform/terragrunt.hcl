# Root terragrunt.hcl


# Налаштування глобальних значень для всіх модулів
locals {
  project     = "GoSell"
  owner       = "voutuk"
  
  # Базові теги, які будуть застосовані до всіх ресурсів
  common_tags = {
    Project     = local.project
    Owner       = local.owner
    ManagedBy   = "terragrunt"
    CreatedAt   = timestamp()
  }
}

# Global variables that can be referenced in child configurations
inputs = {
  doppler_token = get_env("DOPPLER_TOKEN")
  tags          = local.common_tags
}