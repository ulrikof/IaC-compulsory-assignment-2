locals {
  rg_root_base_name    = "uo_rg_deployment"
  sql_server_base_name = "uo-sql-server-1"
  db_base_name         = "uo-db-1"

  rg_root_name = terraform.workspace == "default" ? local.rg_root_base_name : "${local.rg_root_base_name}-${terraform.workspace}"
}