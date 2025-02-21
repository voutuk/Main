provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  environment          = var.environment
  availability_zones   = var.availability_zones
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
}

module "main_instance" {
  source        = "./modules/ec2"
  instance_name = "jenkins-main"
  instance_type = "t3.large"
  ami_id        = var.ami_id
  subnet_id     = module.vpc.public_subnet_ids[0]
  vpc_id        = module.vpc.vpc_id
  key_name      = var.key_name
  environment   = "main"
}

module "test_instances" {
  source        = "./modules/ec2"
  count         = 2
  instance_name = "test-instance-${count.index + 1}"
  instance_type = "t3.medium"
  ami_id        = var.ami_id
  subnet_id     = module.vpc.public_subnet_ids[count.index % length(module.vpc.public_subnet_ids)]
  vpc_id        = module.vpc.vpc_id
  key_name      = var.key_name
  environment   = "test"
}

module "prod_cluster" {
  source          = "./modules/eks"
  cluster_name    = "production-cluster"
  cluster_version = "1.27"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnet_ids
  node_groups = {
    general = {
      desired_size = 2
      max_size     = 4
      min_size     = 1
      instance_types = ["t3.large"]
    }
  }
}

module "backup_bucket" {
  source      = "./modules/s3"
  bucket_name = "my-company-backups-${var.environment}-${formatdate("YYYYMMDD", timestamp())}"
  environment = var.environment
}

module "inventory" {
  source = "./modules/inventory"
  instances = concat(
    [module.main_instance.instance_details],
    module.test_instances[*].instance_details
  )
  inventory_path = "inventory.ini"
}