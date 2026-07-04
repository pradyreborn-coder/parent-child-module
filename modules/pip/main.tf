resource "azurerm_public_ip" "pip" {
  for_each = var.pip

  name                = each.value.name
  location            = var.rgs_info[each.value.rg_key].location
  resource_group_name = var.rgs_info[each.value.rg_key].name
  allocation_method   = "Static"
}