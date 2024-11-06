output "subnet_id" {
  value = azurerm_virtual_network.vnet_1.subnet[0].id
}