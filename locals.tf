locals {
  rg_root_base_name = "uo_rg_root"
  rg_root_name      = terraform.workspace == "default" ? "${locals.rg_root_base_name}" : "${locals.rg_root_base_name}-${terraform.workspace}"
}