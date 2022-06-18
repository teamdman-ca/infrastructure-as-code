resource "azurerm_key_vault" "main" {
  resource_group_name = azurerm_resource_group.main.name
  location            = "canadaeast"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  name                = "ca-teamdman"
}