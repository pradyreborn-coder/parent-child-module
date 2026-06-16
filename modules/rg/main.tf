resource "azurerm_resource_group" "rgs" {

for_each = var.rg

    name = each.key
    location = each.value

}