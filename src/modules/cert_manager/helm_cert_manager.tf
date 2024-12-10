resource "helm_release" "main" {
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.14.5"
  namespace  = kubernetes_namespace.main.metadata.0.name
  name       = "cert-manager"
  set_list {
    name = "extraArgs"
    value = [
      "--cluster-issuer-ambient-credentials",
      "--issuer-ambient-credentials"
    ]
  }
  set {
    name  = "podLabels.azure\\.workload\\.identity/use"
    value = "true"
    # value = "\"true\""
    type  = "string"
  }
  set {
    name  = "serviceAccount.labels.azure\\.workload\\.identity/use"
    value = "true"
    # value = "\"true\""
    type  = "string"
  }
  set {
    name = "installCRDs"
    value = "true"
  }
}
