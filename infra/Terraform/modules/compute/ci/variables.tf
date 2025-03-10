variable "container_name" {
  description = "Name of the container instance"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "storage_account_name" {
  description = "Storage account name"
  type        = string
}

variable "storage_account_key" {
  description = "Storage account key"
  type        = string
  sensitive   = true
}

variable "jenkins_image" {
  description = "Jenkins Docker image"
  type        = string
  default     = "mirror.gcr.io/jenkins/jenkins:lts"
}

variable "cpu" {
  description = "CPU resources for the container"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Memory resources for the container"
  type        = number
  default     = 4
}

variable "doppler_auth" {
  description = "Doppler authentication token"
  type        = string
  sensitive   = true
}

variable "cloudflare_tunnel_token" {
  description = "Cloudflare tunnel token"
  type        = string
  sensitive   = true
}

variable "subnet_id" {
  description = "Subnet ID for container instance"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}