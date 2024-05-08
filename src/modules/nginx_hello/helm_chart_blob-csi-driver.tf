# resource "helm_release" "blob_csi_driver" {
#   repository = "https://raw.githubusercontent.com/kubernetes-sigs/blob-csi-driver/master/charts"
#   chart      = "blob-csi-driver"
#   version    = "v1.24.1"
#   namespace  = "kube-system"
#   name       = "blob-csi-driver"
#   set {
#     name  = "controller.replicas"
#     value = "1"
#   }
#   set {
#     name  = "node.enableBlobfuseProxy"
#     value = "true"
#   }
#   set {
#     name  = "cloud"
#     value = "AzureStackCloud"
#   }
# }
