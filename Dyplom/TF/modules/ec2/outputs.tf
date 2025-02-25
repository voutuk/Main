output "instance_details" {
  description = "EC2 instance details for inventory"
  value = {
    name       = aws_instance.instance.tags.Name
    public_ip  = aws_instance.instance.public_ip
    private_ip = aws_instance.instance.private_ip
    type       = var.environment
  }
}