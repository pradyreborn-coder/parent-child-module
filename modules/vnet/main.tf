resource "azurerm_virtual_network" "vnet" {
  for_each = var.vnet

  name                = each.value.name
  location            = var.rgs_info[each.value.rg_key].location
  resource_group_name = var.rgs_info[each.value.rg_key].name
  address_space       = each.value.address_space
}