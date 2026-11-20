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
