locals {
  rg_root_base_name    = "uo_rg_root"
  sql_server_base_name = "uo-sql-server-1"
  db_base_name         = "uo-db-1"

  rg_root_name    = terraform.workspace == "default" ? local.rg_root_base_name : "${local.rg_root_base_name}-${terraform.workspace}"
  sql_server_name = terraform.workspace == "default" ? local.sql_server_base_name : "${local.sql_server_base_name}-${terraform.workspace}"
  db_name         = terraform.workspace == "default" ? local.db_base_name : "${local.db_base_name}-${terraform.workspace}"
}