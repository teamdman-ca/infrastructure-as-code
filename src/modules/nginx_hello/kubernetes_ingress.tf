resource "kubernetes_ingress_v1" "frontend" {
  metadata {
    name = "frontend"
    namespace = kubernetes_namespace.main.metadata.0.name
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      http {
        path {
            path = "/"
            backend {
                service {
                  name = kubernetes_service.frontend.metadata.0.name
                  port {
                    number = kubernetes_service.frontend.spec.0.port.0.port
                  }
                }
            #   service_name = kubernetes_service.frontend.metadata.0.name
            #   service_port = kubernetes_service.frontend.spec.0.port.0.port
            }
        }
      }
    }
  }
}