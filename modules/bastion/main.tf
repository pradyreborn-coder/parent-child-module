resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastion
  name                = each.value.name
  location            = var.rgs_info[each.value.rg_key].location
  resource_group_name = var.rgs_info[each.value.rg_key].name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnets_info[each.value.subnet_key].id
    public_ip_address_id = var.pips_info[each.value.pip_key].id
  }
}