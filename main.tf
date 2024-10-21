resource "azurerm_resource_group" "uo_rg_root" {
  name     = local.rg_root_name
  location = "West Europe"
}

module "virtual_network_module" {
  source           = "./modules/virtual_network_module"
  rg_name          = azurerm_resource_group.uo_rg_root.name
  location         = azurerm_resource_group.uo_rg_root.location
  vnet_name        = "uo-vnet-1"
  subnet_name      = "uo-subnet-1"
  address_prefixes = ["10.0.0.0/16"]
  address_space    = ["10.0.2.0/24"]
}

module "database_module" {
  source          = "./modules/database_module"
  rg_name         = azurerm_resource_group.uo_rg_root.name
  location        = azurerm_resource_group.uo_rg_root.location
  sql_server_name = local.sql_server_name
  db_name         = local.db_name
}