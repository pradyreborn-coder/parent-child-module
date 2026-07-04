resource "azurerm_network_security_group" "nsg" {
  for_each = var.nsg

  name                = each.value.name
  location            = var.rgs_info[each.value.rg_key].location
  resource_group_name = var.rgs_info[each.value.rg_key].name
}