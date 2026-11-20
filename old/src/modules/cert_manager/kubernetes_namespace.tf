variable "namespace_name" {
  type = string
}
resource "kubernetes_namespace" "main" {
  metadata {
    name = var.namespace_name
  }
}