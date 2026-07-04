resource "azurerm_public_ip" "lb_pip" {
  for_each            = var.lb
  name                = "${each.value.name}-pip"
  location            = var.rgs_info[each.value.rg_key].location
  resource_group_name = var.rgs_info[each.value.rg_key].name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "lb" {
  for_each            = var.lb
  name                = each.value.name
  location            = var.rgs_info[each.value.rg_key].location
  resource_group_name = var.rgs_info[each.value.rg_key].name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_pip[each.key].id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  for_each = var.lb
  name     = "${each.value.name}-backend-pool"
  loadbalancer_id = azurerm_lb.lb[each.key].id
}

# Backend Pool Association for NICs
resource "azurerm_network_interface_backend_address_pool_association" "nic_assoc" {
  for_each = {
    for pair in flatten([
      for lb_key, lb_val in var.lb : [
        for nic_key in lb_val.nic_keys : {
          lb_key  = lb_key
          nic_key = nic_key
        }
      ]
    ]) : "${pair.lb_key}-${pair.nic_key}" => pair
  }

  network_interface_id    = var.nics_info[each.value.nic_key].id
  ip_configuration_name   = "internal" # NIC module mein humne yehi naam rakha hai
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool[each.value.lb_key].id
}

resource "azurerm_lb_probe" "probe" {
  for_each = var.lb
  name     = "http-probe"
  loadbalancer_id = azurerm_lb.lb[each.key].id
  protocol        = "Tcp"
  port            = 80
}

resource "azurerm_lb_rule" "lb_rule" {
  for_each = var.lb
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.lb[each.key].id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.probe[each.key].id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool[each.key].id]
}