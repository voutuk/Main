include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/eks"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id             = "mock-vpc-id"
    private_subnet_ids = ["mock-subnet-1", "mock-subnet-2"]
  }
}

inputs = {
  cluster_name    = "production-cluster"
  cluster_version = "1.27"
  vpc_id          = dependency.vpc.outputs.vpc_id
  subnet_ids      = dependency.vpc.outputs.private_subnet_ids
  node_groups = {
    general = {
      desired_size    = 2
      max_size        = 4
      min_size        = 1
      instance_types  = ["t3.large"]
    }
  }
}