output "wordpress_public_ip" {
  value = azurerm_public_ip.wordpress.fqdn
}

output "jumpbox_public_ip" {
  value = azurerm_public_ip.jumpbox.fqdn
}
