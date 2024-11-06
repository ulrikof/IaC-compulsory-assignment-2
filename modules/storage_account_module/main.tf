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

resource "azurerm_storage_account" "sa" {
  name                     = "${lower(var.sa_base_name)}${random_string.random_string.result}"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

resource "azurerm_storage_container" "sc" {
  name                  = var.sc_name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "html_blob" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.sc.name
  type                   = "Block"
  content_type           = "text/html"
  source_content         = <<-EOT
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Static Web Page</title>
    </head>
    <body>
      <h1>Welcome to My Static Web Page!</h1>
      <p>This is a simple static page hosted on Azure Blob Storage and served through App Service.</p>
    </body>
    </html>
  EOT
}