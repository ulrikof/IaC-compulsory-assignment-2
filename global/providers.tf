terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.1.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "uo_backend_rg"
    storage_account_name = "uo1backend1sa5hl8swws"
    container_name       = "uo-sc-backend"
    key                  = "compulsory_assignment_2_global"
  }
}

provider "azurerm" {
  subscription_id = "30ee9279-e76e-409d-8973-00c9792f6bcb"
  features {
  }
}