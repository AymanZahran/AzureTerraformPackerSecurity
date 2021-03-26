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
  tags = {
    webserver-env = "Production"
  }
}
# Create a Subnet in the production-resources resource group
resource "azurerm_subnet" "Subnet-WebServers" {
  name                 = "Subnet-WebServers"
  resource_group_name  = azurerm_resource_group.RG-WebServers.name
  virtual_network_name = azurerm_virtual_network.VNET-WebServers.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Create a Public IPs in the production-resources resource group
resource "azurerm_public_ip" "PublicIP-WebServer" {
  count = var.NO_VMs
  name                = "PublicIP-WebServer-${count.index}"
  resource_group_name = azurerm_resource_group.RG-WebServers.name
  location            = azurerm_resource_group.RG-WebServers.location
  allocation_method   = "Static"
  tags = {
    webserver-env = "Production"
  }
}

# Create a Network Interfaces in the production-resources resource group
resource "azurerm_network_interface" "VNIC-WebServer" {
  count = var.NO_VMs
  name                = "VNIC-WebServer-${count.index}"
  location            = azurerm_resource_group.RG-WebServers.location
  resource_group_name = azurerm_resource_group.RG-WebServers.name
  ip_configuration {
    name                          = "IPconfig-${count.index}"
    subnet_id                     = azurerm_subnet.Subnet-WebServers.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.PublicIP-WebServer[count.index].id
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
resource "azurerm_network_security_rule" "DenyInternetInbound" {
    name                       = "AllowLocalInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
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

# Associate Network Interfaces to Network Security Groups
resource "azurerm_network_interface_security_group_association" "VNIC-NSG" {
  count = var.NO_VMs
  network_interface_id      = azurerm_network_interface.VNIC-WebServer[count.index].id
  network_security_group_id = azurerm_network_security_group.NSG-WebServers.id
}

#Creating a Public IP for the Load Balancer in the production-resource resource group
resource "azurerm_public_ip" "PublicIP-LB" {
  name                = "PublicIP-LB"
  location            = azurerm_resource_group.RG-WebServers.location
  resource_group_name = azurerm_resource_group.RG-WebServers.name
  allocation_method   = "Static"
  tags = {
    webserver-env = "Production"
  }
}

#Create LoadBalancer
resource "azurerm_lb" "LB-WebServers" {
  name                = "LB-WebServers"
  location            = azurerm_resource_group.RG-WebServers.location
  resource_group_name = azurerm_resource_group.RG-WebServers.name

  frontend_ip_configuration {
    name                 = "Frontend-IPconfig"
    public_ip_address_id = azurerm_public_ip.PublicIP-LB.id
  }
  tags = {
    webserver-env = "Production"
  }
}

#Create LoadBalancer Backend Address Pool
resource "azurerm_lb_backend_address_pool" "BackEndAddressPool" {
  loadbalancer_id = azurerm_lb.LB-WebServers.id
  name            = "BackEndAddressPool"
}

#Associate WebServer NICs to LoadBalancer BackEnd Pool
resource "azurerm_network_interface_backend_address_pool_association" "LB-VNIC-WebServer1" {
  count = var.NO_VMs
  network_interface_id    = azurerm_network_interface.VNIC-WebServer[count.index].id
  ip_configuration_name   = "IPconfig-${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.BackEndAddressPool.id
}

# Create a WebServer Availability Set in the production-resources resource group
resource "azurerm_availability_set" "AS-WebServers" {
  name                = "AS-WebServers"
  location            = azurerm_resource_group.RG-WebServers.location
  resource_group_name = azurerm_resource_group.RG-WebServers.name
  tags = {
    webserver-env = "Production"
  }
}


#Creating Virtual Machines Deployed from Packer Image
resource "azurerm_virtual_machine" "WebServer" {
  count = var.NO_VMs
  name                  = "WebServer${count.index}"
  location              = azurerm_resource_group.RG-WebServers.location
  resource_group_name   = azurerm_resource_group.RG-WebServers.name
  network_interface_ids = [azurerm_network_interface.VNIC-WebServer[count.index].id]
  vm_size               = var.VM_SIZE
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true
  availability_set_id = azurerm_availability_set.AS-WebServers.id

  storage_image_reference {
    id = var.IMAGE_NAME
  }
  storage_os_disk {
    name              = "WebServerOSdisk${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.HOSTNAME
    admin_username = var.USERNAME
    admin_password = var.PASSWORD
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    webserver-env = "Production"
  }
}
