
module "benthic_cluster" {
  source                  = "./modules/cluster"
  resource_group_name     = "CACN-Cluster-Benthic-PROD-RG"
  resource_group_location = "canadacentral"
  resource_group_tags = {
    environment = "Production"
  }
  cluster_name                            = "Benthic-PROD-AKS"
  cluster_dns_prefix                      = "benthic-prod"
  azure_ad_admins_group_name              = "Benthic-PROD-Admins"
  azure_ad_admins_group_member_object_ids = [data.azurerm_client_config.main.object_id]
}
