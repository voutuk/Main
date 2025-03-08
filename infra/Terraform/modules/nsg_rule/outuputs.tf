# modules/nsg_rule/outputs.tf

output "rule_id" {
  value       = azurerm_network_security_rule.rule.id
  description = "ID of the created NSG rule"
}