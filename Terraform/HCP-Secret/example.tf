data "hcp_vault_secrets_app" "ec2" {
  app_name    = "AWS-Keystore"
}

provider "aws" {
  region     = "eu-north-1"
  access_key = data.hcp_vault_secrets_app.ec2.secrets["aws_acces"]
  secret_key = data.hcp_vault_secrets_app.ec2.secrets["aws_secret"]
}

// AWS 1
resource "aws_instance" "AWS-1" {
  availability_zone = "eu-north-1a"
  ami = "ami-0014ce3e52359afbd"
  instance_type = "t3.micro"
  key_name = "BublikKEY"
  vpc_security_group_ids = [aws_security_group.AWS-1.id]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 10
    volume_type = "standard"
    tags = {device_name = "Terraform"}
  }
  tags = {
    Name = "UB-1"
  }
}

resource "aws_security_group" "AWS-1" {
  ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}