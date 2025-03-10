variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "file_share_name" {
  description = "Name of the file share for Jenkins data"
  type        = string
  default     = "jenkins-data"
}

variable "container_name" {
  description = "Name of the container instance"
  type        = string
  default     = "jenkins"
}

variable "jenkins_image" {
  description = "Docker image for Jenkins"
  type        = string
  default     = "mirror.gcr.io/jenkins/jenkins:latest"
}

variable "cpu" {
  description = "CPU cores allocation"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Memory allocation in GB"
  type        = number
  default     = 4
}

variable "cloudflare_tunnel_token" {
  description = "Cloudflare WARP tunnel token"
  type        = string
  sensitive   = true
}

variable "storage_account_name" {
  description = "Name of the storage account to create the file share in"
  type        = string
}

variable "storage_account_key" {
  description = "Primary access key for the storage account"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to all Azure resources"
  type        = map(string)
  default     = {}
}

variable "doppler_auth" {
  description = "Doppler auth token"
  type        = string
  sensitive   = true
}

variable "subnet_id" {
  description = "ID of the subnet for the container instance"
  type        = string
}