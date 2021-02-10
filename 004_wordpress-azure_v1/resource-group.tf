# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = var.location

  tags = {
    Environment = "Development"
    Team        = "DevOps"
  }
}