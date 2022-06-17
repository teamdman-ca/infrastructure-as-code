resource "azurerm_storage_account" "site" {
  resource_group_name      = azurerm_resource_group.main.name
  location                 = "canadaeast"
  name                     = "site502022"
  account_replication_type = "LRS"
  account_tier             = "Standard"

  static_website {
    error_404_document = "404.html"
    index_document = "index.html"
  }
}
