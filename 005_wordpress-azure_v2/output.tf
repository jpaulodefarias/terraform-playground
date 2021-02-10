output "application_public_address" {
  value = azurerm_public_ip.wordpress.fqdn
}

output "jumpbox_public_address" {
  value = azurerm_public_ip.jumpbox.fqdn
}
