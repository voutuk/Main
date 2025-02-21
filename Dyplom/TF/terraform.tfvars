aws_region         = "eu-north-1"
environment        = "production"
ami_id             = "ami-09a9858973b288bdd" # Replace with actual Ubuntu AMI ID
key_name           = "ROOT SSHKEY" # Replace with your SSH key pair name

# VPC Configuration
vpc_cidr             = "10.0.0.0/16"
availability_zones   = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]