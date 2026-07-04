resource "azurerm_windows_virtual_machine" "vm1" {
  for_each            = var.vm1
  name                = each.value.name
  resource_group_name = var.rgs_info[each.value.rg_key].name
  location            = var.rgs_info[each.value.rg_key].location
  size                = each.value.vm_size
  admin_username      = "adminuser"
  admin_password      = "Password@123"

  network_interface_ids = [for nic_key in each.value.nic_keys : var.nics_info[nic_key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "vm2" {
  for_each            = var.vm2
  name                = each.value.name
  resource_group_name = var.rgs_info[each.value.rg_key].name
  location            = var.rgs_info[each.value.rg_key].location
  size                = each.value.vm_size
  admin_username      = "adminuser"
  admin_password      = "Password@123"

  disable_password_authentication = false

  network_interface_ids = [for nic_key in each.value.nic_keys : var.nics_info[nic_key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}