resource "azurerm_service_plan" "service_plan_01" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.rg_name
  os_type             = "Linux"
  sku_name            = var.service_plan_sku
}
