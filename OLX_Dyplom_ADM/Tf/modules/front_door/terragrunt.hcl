include {
  path = find_in_parent_folders()
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
}

terraform {
  source = "."
}

inputs = {
  tags = merge(
    local.common_vars.locals.common_tags,
    {
      Component = "front_door"
    }
  )
  front_door_name      = "gosell-frontdoor"
  backend_host_header  = dependency.aks_cluster.outputs.cluster_fqdn
  backend_address      = dependency.aks_cluster.outputs.cluster_fqdn
}