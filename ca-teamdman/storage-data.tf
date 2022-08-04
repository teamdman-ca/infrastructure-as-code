resource "azurerm_storage_account" "site" {
  resource_group_name      = azurerm_resource_group.main.name
  location                 = "canadaeast"
  name                     = "teamydata"
  account_replication_type = "LRS"
  account_tier             = "Standard"
}
