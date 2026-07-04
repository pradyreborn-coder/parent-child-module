output "subnet_ids" {
  value = { for k, s in azurerm_subnet.subnet : k => s.id }
}

output "subnets_info" {
  value = { for k, s in azurerm_subnet.subnet : k => {
    name                = s.name
    id                  = s.id
    resource_group_name = s.resource_group_name
    vnet_name          = s.virtual_network_name
  } }
}