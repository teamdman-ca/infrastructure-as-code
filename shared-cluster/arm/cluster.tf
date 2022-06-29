resource "azurerm_kubernetes_cluster" "main" {
  resource_group_name = azurerm_resource_group.main.name
  location            = "canadacentral"
  name                = "shared-cluster"
  sku_tier            = "Free"
  dns_prefix          = "sharedcluster"

  default_node_pool {
    name     = "default"
    node_count = 1
    vm_size  = "standard_b2s"
  }


  identity {
    type = "SystemAssigned"
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }
}
