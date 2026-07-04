output "nic_ids" {
  value = { for k, n in azurerm_network_interface.nic : k => n.id }
}

output "nics_info" {
  value = { for k, n in azurerm_network_interface.nic : k => {
    name = n.name
    id   = n.id
  } }
}