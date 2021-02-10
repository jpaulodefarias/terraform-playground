# Create MySQL Server
resource "azurerm_mysql_server" "rg" {
  resource_group_name = azurerm_resource_group.rg.name
  name                = "rg-mysql-server"
  location            = azurerm_resource_group.rg.location
  version             = "5.7"

  administrator_login          = var.database_admin_login
  administrator_login_password = var.database_admin_password

  sku_name                     = "B_Gen5_2"
  storage_mb                   = "5120"
  auto_grow_enabled            = false
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = false
  #ssl_minimal_tls_version_enforced = "TLS1_2"
}

# Create MySql DataBase
resource "azurerm_mysql_database" "rg" {
  name                = "rg-mysql-db"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.rg.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

# Config MySQL Server Firewall Rule
resource "azurerm_mysql_firewall_rule" "rg" {
  name                = "rg-mysql-firewall-rule"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.rg.name
  start_ip_address    = azurerm_public_ip.publicip.ip_address
  end_ip_address      = azurerm_public_ip.publicip.ip_address
}

data "azurerm_mysql_server" "rg" {
  name                = azurerm_mysql_server.rg.name
  resource_group_name = azurerm_resource_group.rg.name
}
