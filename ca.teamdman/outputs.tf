# output "service_principal_password" {
#   sensitive = true
#   value     = azuread_application_password.site_deployer_password.value
# }

data "azurerm_kubernetes_cluster" "shared" {
  resource_group_name = "shared-cluster"
  name                = "shared-cluster"
}

# terraform intellisense only works at topmost level unfortunately
# https://github.com/hashicorp/vscode-terraform/issues/1246

output "external_secrets_operator_config" {
  value = {
    tenant_id           = data.azurerm_client_config.current.tenant_id
    subscription_id     = data.azurerm_client_config.current.subscription_id
    key_vault_uri       = azurerm_key_vault.main.vault_uri
    managed_identity_id = data.azurerm_kubernetes_cluster.shared.kubelet_identity[0].client_id
    # managed_identity_id = data.azurerm_kubernetes_cluster.shared.kubelet_identity[0].object_id
  }
}

output "letsencrypt_config" {
  value = {
    subscriptionID    = data.azurerm_client_config.current.subscription_id
    resourceGroupName = azurerm_resource_group.main.name
    hostedZoneName    = azurerm_dns_zone.main.name
    managedIdentity = {
      clientID = data.azurerm_kubernetes_cluster.shared.kubelet_identity[0].client_id
    }
  }
}

output "external_dns_config" {
  value = {
    resourceGroup               = azurerm_resource_group.main.name
    tenandId                    = data.azurerm_client_config.current.tenant_id
    subscriptionId              = data.azurerm_client_config.current.subscription_id
    useManagedIdentityExtension = true
    userAssignedIdentityID      = data.azurerm_kubernetes_cluster.shared.kubelet_identity[0].client_id
  }
}