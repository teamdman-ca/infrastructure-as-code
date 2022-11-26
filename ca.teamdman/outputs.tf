output "service_principal_password" {
  sensitive = true
  value     = azuread_application_password.site_deployer_password.value
}

data "azurerm_kubernetes_cluster" "shared" {
  resource_group_name = "shared-cluster"
  name                = "shared-cluster"
}

output "external_secrets_operator_config" {
  sensitive = true
  value = {
    tenant_id           = data.azurerm_client_config.current.tenant_id
    subscription_id     = data.azurerm_client_config.current.subscription_id
    key_vault_uri       = azurerm_key_vault.main.vault_uri
    managed_identity_id = data.azurerm_kubernetes_cluster.shared.kubelet_identity[0].object_id
  }
}