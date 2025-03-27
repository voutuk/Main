variable "domain_name" {
  description = "The domain name managed in Cloudflare"
  type        = string
}

variable "record_name" {
  description = "The DNS record name to create (without the domain)"
  type        = string
}

variable "ingress_controller_service_name" {
  description = "The name of the ingress controller service"
  type        = string
  default     = "ingress-nginx-controller"
}

variable "ingress_controller_namespace" {
  description = "The Kubernetes namespace where the ingress controller is deployed"
  type        = string
  default     = "ingress-nginx"
}

variable "ttl" {
  description = "The TTL for the DNS record (1 for automatic)"
  type        = number
  default     = 1
}

variable "proxied" {
  description = "Whether the record should be proxied through Cloudflare"
  type        = bool
  default     = true
}

variable "kubernetes_config_path" {
  description = "The path to the Kubernetes config file"
  type        = string
  default     = "~/.kube/config"
}
variable "kubernetes_context" {
  description = "The Kubernetes context to use"
  type        = string
}