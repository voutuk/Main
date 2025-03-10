output "jenkins_fqdn" {
  description = "The FQDN of the Jenkins container instance"
  value       = azurerm_container_group.jenkins.fqdn
}

output "jenkins_ip" {
  description = "The IP address of the Jenkins container instance"
  value       = azurerm_container_group.jenkins.ip_address
}