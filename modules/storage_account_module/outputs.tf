output "sa_name" {
  value = azurerm_storage_account.sa.name
}

output "sa_access_key" {
  value = azurerm_storage_account.sa.primary_access_key
}

output "sc_name" {
  value = azurerm_storage_container.sc.name
}

output "sb_index_name" {
  value = azurerm_storage_blob.html_blob.name
}