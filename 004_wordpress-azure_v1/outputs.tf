output "public_ip_address" {
  value = data.azurerm_public_ip.ip.ip_address
}

output "public_ip_fqdn" {
  value = azurerm_public_ip.publicip.fqdn
}

output "database_fqdn" {
  value = data.azurerm_mysql_server.wordpress.fqdn
}