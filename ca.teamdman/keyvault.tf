resource "azurerm_key_vault" "main" {
  resource_group_name = azurerm_resource_group.main.name
  location            = "canadaeast"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  name                = "ca-teamdman"
}

locals {
  key_vault_secrets = {
    "storage-account-name" = azurerm_storage_account.main.name
    "storage-account-key"  = azurerm_storage_account.main.primary_access_key
  }
}

resource "azurerm_key_vault_secret" "main" {
  for_each     = local.key_vault_secrets
  key_vault_id = azurerm_key_vault.main.id
  name         = each.key
  value        = each.value
}

resource "azurerm_key_vault_access_policy" "external-secrets-operator" {
  key_vault_id       = azurerm_key_vault.main.id
  secret_permissions = ["Get", "List"]
  tenant_id          = azurerm_key_vault.main.tenant_id
  object_id          = data.azurerm_kubernetes_cluster.shared.kubelet_identity[0].object_id
}