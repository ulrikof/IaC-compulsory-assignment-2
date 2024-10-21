resource "azurerm_app_service_plan" "service_plan_01" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.rg_name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service_01" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.rg_name
  app_service_plan_id = azurerm_app_service_plan.service_plan_01.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  storage_account {
    name         = "sa_01"
    account_name = var.sa_name
    share_name   = var.sc_name
    access_key   = var.sa_access_key
    type         = "Blob"
  }

  connection_string {
    name  = "Database"
    type  = "SQLAzure"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}