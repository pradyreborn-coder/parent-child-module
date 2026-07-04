resource "azurerm_network_interface" "nic" {
  for_each = var.nic

  name                = each.value.name
  location            = var.rgs_info[each.value.rg_key].location
  resource_group_name = var.rgs_info[each.value.rg_key].name

  ip_configuration {
    name                          = each.value.ipname
    subnet_id                     = var.subnets_info[each.value.subnet_key].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
  }
}