variable "cluster_name" {
  type = string
}
variable "cluster_dns_prefix" {
  type = string
}
resource "azurerm_kubernetes_cluster" "main" {
  resource_group_name               = azurerm_resource_group.main.name
  location                          = azurerm_resource_group.main.location
  tags                              = azurerm_resource_group.main.tags
  name                              = var.cluster_name
  dns_prefix                        = var.cluster_dns_prefix
  sku_tier                          = "Free"
  kubernetes_version                = "1.28"
  oidc_issuer_enabled               = true
  workload_identity_enabled         = true
  role_based_access_control_enabled = true
  storage_profile {
    blob_driver_enabled = true
  }
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_b2s"
    upgrade_settings {
      max_surge = "10%"
    }
  }

  identity {
    type = "SystemAssigned"
  }


  network_profile {
    network_plugin = "kubenet"
  }


  azure_active_directory_role_based_access_control {
    # There is a deprecation warning here, we must continue to specify managed=true until it is removed
    managed            = true
    azure_rbac_enabled = true
    admin_group_object_ids = [
      azuread_group.admins.object_id
    ]
  }
}
