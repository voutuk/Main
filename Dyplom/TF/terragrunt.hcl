# Root terragrunt.hcl
locals {
  # Parse the path to get the environment name
  environment = path_relative_to_include()

  # Load environment specific variables
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

# Remote state configuration
remote_state {
  backend = "s3"
  config = {
    bucket         = "terraform-state-${local.environment}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"  # Adjust based on your requirements
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

# Generate provider configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "${local.env_vars.locals.aws_region}"
  
  default_tags {
    tags = {
      Environment = "${local.environment}"
      ManagedBy   = "Terragrunt"
      Owner       = "voutuk"
    }
  }
}
EOF
}

# Common inputs that can be referenced by child configurations
inputs = merge(
  local.env_vars.locals,
  {
    environment = local.environment
  }
)