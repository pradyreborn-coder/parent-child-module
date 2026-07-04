resource "azurerm_virtual_network_peering" "peering" {
  for_each                  = var.vnet_peering
  name                      = each.value.name
  resource_group_name       = var.rgs_info[each.value.rg_key].name
  virtual_network_name      = var.vnets_info[each.value.vnet_key].name
  remote_virtual_network_id = var.vnets_info[each.value.remote_vnet_key].id
}