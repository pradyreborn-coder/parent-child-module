output "rg_names" {
  value = module.rg.rg_names
}

output "vnet_names" {
  value = module.vnet.vnet_names
}

output "subnet_ids" {
  value = module.subnet.subnet_ids
}

output "nic_ids" {
  value = module.nic.nic_ids
}

output "pip_ids" {
  value = module.pip.pip_ids
}

output "nsg_ids" {
  value = module.nsg.nsg_ids
}
