variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "front_door_name" {
  description = "Name of the Azure Front Door"
  type        = string
}

variable "backend_host_header" {
  description = "Host header for the backend"
  type        = string
}

variable "backend_address" {
  description = "Address for the backend"
  type        = string
}

variable "tags" {
  description = "Tags for the Azure Front Door"
  type        = map(string)
}