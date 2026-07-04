resource "azurerm_subnet" "subnet" {
  for_each = var.snet

  name                 = each.value.name
  resource_group_name  = var.rgs_info[each.value.rg_key].name
  virtual_network_name = var.vnets_info[each.value.vnet_key].name
  address_prefixes     = each.value.address_prefixes
}