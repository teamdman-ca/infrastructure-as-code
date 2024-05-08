resource "helm_release" "cert_manager" {
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "v4.10.1"
  namespace  = kubernetes_namespace.main.metadata.0.name
  name       = "ingress-nginx"
  set {
    name = "ingress.extra_args.enable-ssl-passthrough"
    value = "true"
  }
  set {
    name = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-health-probe-request-path"
    value = "/healthz"
  }
}
