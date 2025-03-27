output "ingress_public_ip" {
  description = "The public IP address of the ingress controller"
  value       = data.kubernetes_service.ingress_controller.status.0.load_balancer.0.ingress.0.ip
}

output "cloudflare_record_id" {
  description = "The ID of the created Cloudflare DNS record"
  value       = cloudflare_record.ingress.id
}

output "cloudflare_record_hostname" {
  description = "The full hostname of the created record"
  value       = "${cloudflare_record.ingress.name}.${var.domain_name}"
}