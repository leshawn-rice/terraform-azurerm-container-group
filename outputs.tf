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
