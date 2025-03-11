variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "sku" {
  description = "The SKU name of the container registry"
  type        = string
  default     = "Basic"
}

variable "admin_enabled" {
  description = "Specifies whether the admin user is enabled"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "service_principal_id" {
  description = "The ID of the service principal to assign AcrPush role"
  type        = string
  default     = ""
}

variable "pull_principal_ids" {
  description = "List of principal IDs to assign AcrPull role"
  type        = list(string)
  default     = []
}

variable "jenkinsfile_path" {
  description = "Path where the Jenkinsfile.push should be created"
  type        = string
  default     = "../Jenkins/Jenkinsfile.push"
}

