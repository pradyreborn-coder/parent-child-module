output "rg_names" {
  value = { for k, rg in azurerm_resource_group.rgs : k => rg.name }
}

output "rg_ids" {
  value = { for k, rg in azurerm_resource_group.rgs : k => rg.id }
}

output "rg_locations" {
  value = { for k, rg in azurerm_resource_group.rgs : k => rg.location }
}