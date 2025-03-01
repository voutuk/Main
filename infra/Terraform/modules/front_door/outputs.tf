output "front_door_id" {
  value = azurerm_frontdoor.front_door.id
}

output "front_door_endpoint" {
  value = "https://${azurerm_frontdoor.front_door.frontend_endpoint[0].host_name}"
}