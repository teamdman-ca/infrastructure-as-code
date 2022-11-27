resource "azurerm_kubernetes_cluster" "main" {
  resource_group_name = azurerm_resource_group.main.name
  location            = "canadacentral"
  name                = "teamdman-aks"
  sku_tier            = "Free"
  dns_prefix          = "sharedcluster"
  kubernetes_version = "1.24.6"
  default_node_pool {
    name     = "default"
    node_count = 1
    vm_size  = "standard_b2s"
  }


  identity {
    type = "SystemAssigned"
  }
}
