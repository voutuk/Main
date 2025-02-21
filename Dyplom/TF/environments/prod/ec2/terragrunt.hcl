include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/ec2"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id             = "mock-vpc-id"
    public_subnet_ids  = ["mock-subnet-1", "mock-subnet-2"]
  }
}

inputs = {
  instance_name = "jenkins-main"
  instance_type = "t3.large"
  subnet_id     = dependency.vpc.outputs.public_subnet_ids[0]
  vpc_id        = dependency.vpc.outputs.vpc_id
}