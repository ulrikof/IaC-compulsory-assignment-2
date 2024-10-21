resource "azurerm_service_plan" "service_plan_01" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.rg_name
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "web_app" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.rg_name
  service_plan_id     = azurerm_service_plan.service_plan_01.id

  site_config {}

  storage_account {
    name         = "sa_01"
    account_name = var.sa_name
    share_name   = var.sc_name
    access_key   = var.sa_access_key
    type         = "AzureBlob"
  }

  connection_string {
    name  = "Database"
    type  = "SQLAzure"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}