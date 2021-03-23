# Create a resource group
resource "azurerm_resource_group" "RG-WebServers" {
  name     = "production-resources"
  location = var.AZURE_LOCATION

  tags = {
    webserver-env = "Production"
  }
}

# Create a virtual network in the production-resources resource group
resource "azurerm_virtual_network" "VNET-WebServers" {
  name                = "production-network"
  resource_group_name = azurerm_resource_group.RG-WebServers.name
  location            = azurerm_resource_group.RG-WebServers.location
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "Subnet-FrontEnd"
    address_prefix = "10.0.0.0/24"
  }

  tags = {
    webserver-env = "Production"
  }
}

#Creating a Network Security Group in the production-resource resource group
resource "azurerm_network_security_group" "NSG-WebServers" {
  name                = "production-nsgs"
  location            = azurerm_resource_group.RG-WebServers.location
  resource_group_name = azurerm_resource_group.RG-WebServers.name
  
  tags = {
    webserver-env = "Production"
  }
}

resource "azurerm_network_security_rule" "AllowLocalInbound" {
    name                       = "AllowLocalInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.0.0/24"
    destination_address_prefix = "10.0.0.0/24"
    resource_group_name         = azurerm_resource_group.RG-WebServers.name
    network_security_group_name = azurerm_network_security_group.NSG-WebServers.name
  }
resource "azurerm_network_security_rule" "AllowLocalOutbound" {
    name                       = "AllowLocalOutbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.0.0/24"
    destination_address_prefix = "10.0.0.0/24"
    resource_group_name         = azurerm_resource_group.RG-WebServers.name
    network_security_group_name = azurerm_network_security_group.NSG-WebServers.name
  }






