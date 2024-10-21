resource "azurerm_network_security_group" "example" {
  name                = "example-security-group"
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]


  subnet {
    name             = var.subnet_name
    address_prefixes = ["10.0.2.0/24"]
    security_group   = azurerm_network_security_group.example.id
  }
}