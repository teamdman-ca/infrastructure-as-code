# This can take several minutes.
# A bug has been fixed that made it take hours.
resource "azurerm_kubernetes_cluster" "main" {
  resource_group_name       = azurerm_resource_group.main.name
  location                  = "canadacentral"
  name                      = "my-aks-cluster-1"
  sku_tier                  = "Free"
  dns_prefix                = "sharedcluster"
  
  # az aks get-versions -l canada-central --query "orchestrators[*].orchestratorVersion"
  kubernetes_version        = "1.28.0"
  
  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_b2s"
  }


  identity {
    type = "SystemAssigned"
  }
}