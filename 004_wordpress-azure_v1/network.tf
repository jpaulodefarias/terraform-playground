# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "wordpressVnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.wordpress.name
}

# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "wordpressSubnet"
  resource_group_name  = azurerm_resource_group.wordpress.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create public IP
resource "azurerm_public_ip" "publicip" {
  name                = "wordpressPublicIP"
  location            = var.location
  resource_group_name = azurerm_resource_group.wordpress.name
  allocation_method   = "Static"
  domain_name_label   = random_string.fqdn.result
}


# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg" {
  name                = "wordpressNSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.wordpress.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "nic" {
  name                = "myNIC"
  location            = var.location
  resource_group_name = azurerm_resource_group.wordpress.name

  ip_configuration {
    name                          = "myNICConfg"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

data "azurerm_public_ip" "ip" {
  name                = azurerm_public_ip.publicip.name
  resource_group_name = azurerm_virtual_machine.vm.resource_group_name
  depends_on          = [azurerm_virtual_machine.vm]
}
