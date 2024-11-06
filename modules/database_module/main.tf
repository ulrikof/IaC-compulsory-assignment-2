locals {
  sanitized_sql_server_name = substr(
    trim(
      replace(replace(replace(
        lower(var.sql_server_name),
        "_", "-"),                # Replace underscores with hyphens
        ".", "-"),                # Replace dots with hyphens
        " ", "-"),                # Replace spaces with hyphens
      "-"),                       # Trim hyphens from start and end
    0,
    63
  )
}

resource "azurerm_mssql_server" "sql_server_1" {
  name                         = local.sanitized_sql_server_name
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_mssql_database" "sql_database" {
  name         = lower(var.db_name)
  server_id    = azurerm_mssql_server.sql_server_1.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"
}