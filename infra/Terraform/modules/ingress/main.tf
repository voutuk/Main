# Get the Ingress Controller Load Balancer public IP
data "kubernetes_service" "ingress_controller" {
  metadata {
    name      = var.ingress_controller_service_name
    namespace = var.ingress_controller_namespace
  }
}

# Get the Cloudflare zone ID
data "cloudflare_zone" "domain" {
  name = var.domain_name
}

# Create or update a DNS record in Cloudflare
resource "cloudflare_record" "ingress" {
  zone_id = data.cloudflare_zone.domain.id
  name    = var.record_name
  value   = data.kubernetes_service.ingress_controller.status.0.load_balancer.0.ingress.0.ip
  type    = "A"
  ttl     = var.ttl
  proxied = var.proxied
}