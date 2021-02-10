# Create a Linux virtual machine
resource "azurerm_virtual_machine" "vm" {
  name                  = "wordpressVM"
  location              = var.location
  resource_group_name   = azurerm_resource_group.wordpress.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "myOsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "wordpressVM"
    admin_username = var.admin_username
    admin_password = var.admin_password
    custom_data    = file("web.conf")
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
