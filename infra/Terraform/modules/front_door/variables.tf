variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "West Europe"
}

variable "aks_cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "front_door_name" {
  description = "The name of the Front Door resource"
  type        = string
}

variable "domain_name" {
  description = "The custom domain name for the application"
  type        = string
  default     = "pluton.pp.ua"
}

variable "front_door_sku" {
  description = "The SKU of the Front Door resource"
  type        = string
  default     = "Standard_AzureFrontDoor"
}

variable "node_resource_group_name" {
  description = "Resource group where the AKS node resources are deployed"
  type        = string
}
variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}