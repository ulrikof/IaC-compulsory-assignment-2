locals {
  rg_root_name = terraform.workspace == "default" ? "${var.rg_root_name}" : "${var.rg_root_name}-${terraform.workspace}"
}