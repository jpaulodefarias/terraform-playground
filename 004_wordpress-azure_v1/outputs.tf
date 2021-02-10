output "application_address" {
  value = azurerm_public_ip.publicip.fqdn
}

output "database_address" {
  value = data.azurerm_mysql_server.wordpress.fqdn
}