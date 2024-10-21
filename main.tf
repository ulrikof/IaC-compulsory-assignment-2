resource "azurerm_resource_group" "uo_rg_root" {
    name = local.rg_root_name
    location = "West Europe"
}
