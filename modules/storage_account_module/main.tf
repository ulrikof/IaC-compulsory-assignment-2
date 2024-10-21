resource "azurerm_storage_account" "sa-01" {
  name                     = var.sa_01_name
  resource_group_name      = var.location
  location                 = var.rg_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sc-01" {
  name                  = var.sc_01_name
  storage_account_name  = azurerm_storage_account.sa-01.name
  container_access_type = "blob"
}