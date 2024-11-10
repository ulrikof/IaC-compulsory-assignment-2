resource "azurerm_resource_group" "global_rg" {
  name     = "uo_rg_global"
  location = "West Europe"
}

data "azurerm_client_config" "current" {}

resource "azurerm_log_analytics_workspace" "global_log_analytics" {
  name                = "global-log-analytics"
  location            = azurerm_resource_group.global_rg.location
  resource_group_name = azurerm_resource_group.global_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_key_vault" "global_key_vault" {
  name                = "global-key-vault"
  location            = azurerm_resource_group.global_rg.location
  resource_group_name = azurerm_resource_group.global_rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
  }
}