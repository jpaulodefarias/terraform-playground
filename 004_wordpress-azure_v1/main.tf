# Create a resource group
resource "azurerm_resource_group" "wordpress" {
  name     = "wordpressResourceGroup"
  location = var.location

  tags = {
    Environment = "Development"
  }
}

# Create a random hostname
resource "random_string" "fqdn" {
  length  = 6
  special = false
  upper   = false
  number  = false
}