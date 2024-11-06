resource "azurerm_network_security_group" "nsg_1" {
  name                = "example-security-group"
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_virtual_network" "vnet_1" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]



}

resource "azurerm_subnet" "subnet_1" {
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet_1.name
  name             = var.subnet_name
  address_prefixes = ["10.0.2.0/24"]
  
}

resource "azurerm_subnet_network_security_group_association" "subnet_1_nsg" {
  subnet_id                 = azurerm_subnet.subnet_1.id
  network_security_group_id = azurerm_network_security_group.nsg_1.id
}