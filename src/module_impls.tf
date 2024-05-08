data "azurerm_client_config" "main" {}

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


resource "null_resource" "helm_repo_cert_manager" {
  provisioner "local-exec" {
    command = "helm repo add jetstack https://charts.jetstack.io --force-update"
    when    = create
  }
}

module "cert_manager" {
  source         = "./modules/cert_manager"
  depends_on     = [module.benthic_cluster, null_resource.helm_repo_cert_manager]
  namespace_name = "cert-manager"
}

module "ingress_nginx" {
  source         = "./modules/ingress_nginx"
  depends_on     = [module.benthic_cluster]
  namespace_name = "ingress-nginx"
}
