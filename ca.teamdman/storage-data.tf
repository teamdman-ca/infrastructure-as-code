resource "azurerm_storage_account" "main" {
  resource_group_name      = azurerm_resource_group.main.name
  location                 = "canadaeast"
  name                     = "teamdman"
  account_replication_type = "LRS"
  account_tier             = "Standard"
}
