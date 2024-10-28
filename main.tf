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

module "storage_account_module" {
  source       = "./modules/storage_account_module"
  rg_name      = azurerm_resource_group.uo_rg_root.name
  location     = azurerm_resource_group.uo_rg_root.location
  sa_base_name = "uo1sa01"
  sc_name      = "uo-sc-01"
}

module "app_service_module" {
  source            = "./modules/app_service_module"
  rg_name           = azurerm_resource_group.uo_rg_root.name
  location          = azurerm_resource_group.uo_rg_root.location
  service_plan_name = "service_plan_01"
  app_service_name  = "app1"
  sa_name           = module.storage_account_module.sa_name
  sa_access_key     = module.storage_account_module.sa_access_key
  sc_name           = module.storage_account_module.sc_name
}
