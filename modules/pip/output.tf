output "pip_ids" {
  value = { for k, p in azurerm_public_ip.PIP : k => p.id }
}