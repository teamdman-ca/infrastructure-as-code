data "azurerm_resources" "traefik" {
  resource_group_name = "Personal.Core.AKS.Nodes.RG"
  type                = "Microsoft.Network/publicIPAddresses"

  required_tags = {
    "k8s-azure-service" = "traefik/traefik"
  }

  lifecycle {
    postcondition {
      condition     = length(self.resources) == 1
      error_message = "Expected one public IP tagged k8s-azure-service=traefik/traefik in Personal.Core.AKS.Nodes.RG."
    }
  }
}
