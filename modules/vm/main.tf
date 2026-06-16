resource "azurerm_virtual_machine" "vm_win" {

  for_each              = var.vm1
  name                  = each.value.name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = [for key in each.value.nic_keys : var.nic_ids[key]]
  vm_size               = each.value.vm_size


  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${each.value.name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "vm-win"
    admin_password = "VM_windows@1"
  }
  os_profile_windows_config {
    provision_vm_agent = true
  }
  tags = {
    environment = "staging"
  }
}

resource "azurerm_virtual_machine" "vm_linux" {

  for_each              = var.vm2
  name                  = each.value.name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = [for key in each.value.nic_keys : var.nic_ids[key]]
  vm_size               = each.value.vm_size


  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdiskl1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "vm-linux"
    admin_password = "VM_windows@1"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}