resource "azurerm_storage_account" "main" {
  resource_group_name      = azurerm_resource_group.main.name
  location                 = "canadaeast"
  name                     = "teamdman"
  account_replication_type = "LRS"
  account_tier             = "Standard"

  static_website {
    error_404_document = "404.html"
    index_document     = "index.html"
  }
}

resource "azurerm_storage_container" "web" {
  storage_account_name = azurerm_storage_account.main.name
  name                 = "$web"
}

resource "azurerm_role_assignment" "site_write" {
  principal_id         = azuread_service_principal.site_deployer.object_id
  scope                = azurerm_storage_account.main.id
  role_definition_name = "Storage Blob Data Contributor"
}