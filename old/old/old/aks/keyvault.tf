resource "azurerm_key_vault" "main" {
  resource_group_name = azurerm_resource_group.main.name
  location            = "canadaeast"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  name                = "ca-teamdman"
}

resource "azurerm_key_vault_secret" "main" {
  for_each = {
    "storage-account-name" = azurerm_storage_account.main.name
    "storage-account-key"  = azurerm_storage_account.main.primary_access_key
  }
  key_vault_id = azurerm_key_vault.main.id
  name         = each.key
  value        = each.value
  depends_on = [
    azurerm_key_vault_access_policy.me
  ]
}

resource "azurerm_key_vault_access_policy" "external-secrets-operator" {
  key_vault_id       = azurerm_key_vault.main.id
  secret_permissions = ["Get", "List"]
  tenant_id          = azurerm_key_vault.main.tenant_id
  object_id          = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
}

###

# this does not scale to team projects
locals {
  key_vault_reader_object_ids = [
data.azurerm_client_config.current.object_id
  ]
}
resource "azurerm_key_vault_access_policy" "me" {
  for_each = local.key_vault_reader_object_ids
  key_vault_id = azurerm_key_vault.main.id
  secret_permissions = [
    "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
  ]
  certificate_permissions = [
    "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"
  ]
  key_permissions = [
    "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"
  ]
  tenant_id = azurerm_key_vault.main.tenant_id
  object_id = each.value
}
