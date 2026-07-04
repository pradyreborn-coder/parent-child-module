output "vnet_names" {
  value = { for k, v in azurerm_virtual_network.vnet : k => v.name }
}

output "vnet_ids" {
  value = { for k, v in azurerm_virtual_network.vnet : k => v.id }
}

output "vnets_info" {
  value = { for k, v in azurerm_virtual_network.vnet : k => {
    name                = v.name
    id                  = v.id
    resource_group_name = v.resource_group_name
  } }
}