resource "azurerm_user_assigned_identity" "gifts" {
  resource_group_name = azurerm_resource_group.main.name
  name                = "gifts"
  location            = "canadacentral"
}

resource "azurerm_federated_identity_credential" "gifts" {
  resource_group_name = azurerm_resource_group.main.name
  parent_id           = azurerm_user_assigned_identity.gifts.id
  name                = "gifts"
  issuer              = azurerm_kubernetes_cluster.main.oidc_issuer_url
  subject             = "system:serviceaccount:teamdman-gifts:gifts-sa"
  audience            = ["api://AzureADTokenExchange"]
}