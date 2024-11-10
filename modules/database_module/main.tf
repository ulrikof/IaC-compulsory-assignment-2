terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

resource "random_string" "random_string" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_mssql_server" "sql_server_1" {
  name                         = "${lower(var.sql_server_base_name)}-${random_string.random_string.result}"
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_server_admin_login
  administrator_login_password = var.sql_server_admin_password
}

resource "azurerm_mssql_database" "sql_database" {
  name         = "${lower(var.sql_server_base_name)}-${random_string.random_string.result}"
  server_id    = azurerm_mssql_server.sql_server_1.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = var.db_max_gb
  sku_name     = var.db_sku
  enclave_type = "VBS"
}