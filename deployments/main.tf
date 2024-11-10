resource "azurerm_resource_group" "uo_rg_root" {
  name     = local.rg_root_name
  location = "West Europe"
}

module "virtual_network_module" {
  source           = "./../modules/virtual_network_module"
  rg_name          = azurerm_resource_group.uo_rg_root.name
  location         = azurerm_resource_group.uo_rg_root.location
  vnet_name        = "uo-vnet-1"
  subnet_name      = "uo-subnet-1"
  address_prefixes = ["10.0.0.0/16"]
  address_space    = ["10.0.2.0/24"]
  nsg_01_name      = "NSG_01"
}

module "database_module" {
  source                    = "./../modules/database_module"
  rg_name                   = azurerm_resource_group.uo_rg_root.name
  location                  = azurerm_resource_group.uo_rg_root.location
  sql_server_base_name      = "uo-sql-server-1"
  db_base_name              = "uo-db-1"
  sql_server_admin_login    = var.sql_server_admin_login
  sql_server_admin_password = var.sql_server_admin_password
  db_max_gb                 = var.db_max_gb
  db_sku                    = var.db_sku
}

module "storage_account_module" {
  source       = "./../modules/storage_account_module"
  rg_name      = azurerm_resource_group.uo_rg_root.name
  location     = azurerm_resource_group.uo_rg_root.location
  sa_base_name = "uo1sa01"
  sc_name      = "uo-sc-01"
}

module "linux_service_plan_module" {
  source            = "../modules/linux_service_plan_module"
  rg_name           = azurerm_resource_group.uo_rg_root.name
  location          = azurerm_resource_group.uo_rg_root.location
  service_plan_name = "service_plan_01"
  service_plan_sku  = var.service_plan_sku
}

module "load_balancer_module" {
  source         = "./../modules/load_balancer_module"
  rg_name        = azurerm_resource_group.uo_rg_root.name
  location       = azurerm_resource_group.uo_rg_root.location
  lb_name        = "load_balancer_01"
  public_ip_name = "public_ip_01"
}
