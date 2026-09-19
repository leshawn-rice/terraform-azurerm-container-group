output "name" {
  value       = azurerm_container_group.this.name
  description = "The Name of the Resource Group."
}

output "id" {
  value       = azurerm_container_group.this.id
  description = "The ID of the Resource Group."
}

output "location" {
  value       = azurerm_container_group.this.location
  description = "The Azure Region where the Resource Group exists."
}

output "ip_address" {
  value       = azurerm_container_group.this.ip_address
  description = "The IP address allocated to the Container Group."
}

output "fqdn" {
  value       = azurerm_container_group.this.fqdn
  description = "The FQDN of the Container Group, when a dns_name_label is set."
}

output "identity_principal_id" {
  value       = try(azurerm_container_group.this.identity[0].principal_id, null)
  description = "The Principal ID of the Container Group's managed identity, if one is configured."
}
