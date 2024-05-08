module "ingress_nginx" {
  source         = "./modules/ingress_nginx"
  depends_on     = [module.benthic_cluster]
  namespace_name = "ingress-nginx"
}
