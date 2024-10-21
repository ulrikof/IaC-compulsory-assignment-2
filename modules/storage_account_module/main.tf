terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

# Random string used added to the name of sa_01 to make a valid name
resource "random_string" "random_string" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_storage_account" "sa_01" {
  name                     = "${lower(var.sa_01_base_name)}${random_string.random_string.result}"
  resource_group_name      = var.location
  location                 = var.rg_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sc_01" {
  name                  = var.sc_01_name
  storage_account_name  = azurerm_storage_account.sa_01.name
  container_access_type = "blob"
}