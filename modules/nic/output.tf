output "nic_ids" {
  value = { for k, n in azurerm_network_interface.nic : k => n.id }
}