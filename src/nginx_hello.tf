resource "random_string" "suffix" {
  upper   = false
  length  = 6
  special = false
}

module "nginx_hello" {
  source                    = "./modules/nginx_hello"
  depends_on                = [module.benthic_cluster]
  storage_account_name      = "nginxhelloweb${random_string.suffix.result}"
  kubernetes_namespace_name = "nginx-hello"
  resource_group_name       = "CACN-ClusterWorkload-Benthic-nginx-PROD-RG"
  resource_group_location   = "canadacentral"
  resource_group_tags = {
    environment = "Production"
  }
}
