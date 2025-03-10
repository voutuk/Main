# modules/storage/variables.tf

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "storage_prefix" {
  type = string
}

variable "container_name" {
  type        = string
  default     = "storage"
  description = "The name of the container in the Storage Account will be stored."
}



variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the Storage Account and container."
  default     = {}
}