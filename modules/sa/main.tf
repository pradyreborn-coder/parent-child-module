resource "azurerm_storage_account" "sa" {

for_each = var.sa_name

  name                     = each.value.name 
  resource_group_name      = var.rgs_info[each.value.rg_key].name
  location                 = var.rgs_info[each.value.rg_key].location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  for_each = var.sa_name
  name                  = "container"
  storage_account_id    = azurerm_storage_account.sa[each.key].id
  container_access_type = "private"
}