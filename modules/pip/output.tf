output "pip_ids" {
  value = { for k, p in azurerm_public_ip.pip : k => p.id }
}

output "pips_info" {
  value = { for k, p in azurerm_public_ip.pip : k => {
    name = p.name
    id   = p.id
  } }
}