# modules/backup_storage/variables.tf

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "backup_storage_prefix" {
  type = string
}

variable "container_name" {
  type        = string
  default     = "backups"
  description = "The name of the container in the Storage Account where backups will be stored."
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the Storage Account and container."
  default     = {}
}