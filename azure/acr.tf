resource "azurerm_container_registry" "main" {
  resource_group_name = azurerm_resource_group.main.name
  name = "teamdman"
  sku = "Standard"
  location = "canadacentral"
}

resource "azurerm_role_assignment" "acrpull" {
  scope                = azurerm_container_registry.main.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.main.identity.0.principal_id
}