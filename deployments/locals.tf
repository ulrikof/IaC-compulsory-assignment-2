locals {
  rg_root_base_name    = "uo_rg_deployment"
  rg_root_name    = terraform.workspace == "default" ? local.rg_root_base_name : "${local.rg_root_base_name}-${terraform.workspace}"
}