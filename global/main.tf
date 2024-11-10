resource "azurerm_resource_group" "global_rg" {
  name     = "uo_rg_global"
  location = "West Europe"
}


resource "azurerm_log_analytics_workspace" "global_log_analytics" {
  name                = "global-log-analytics"
  location            = azurerm_resource_group.global_rg.location
  resource_group_name = azurerm_resource_group.global_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

