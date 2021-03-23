# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "production-resources"
  location = var.AZURE_LOCATION
}

# Create a virtual network in the production-resources resource group
resource "azurerm_virtual_network" "test" {
  name                = "production-network"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
  tags = {
    webserver-env = "Production"
  }
}
