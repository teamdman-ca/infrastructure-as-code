data "azurerm_public_ip" "traefik" {
  name                = one(data.azurerm_resources.traefik.resources).name
  resource_group_name = data.azurerm_resources.traefik.resource_group_name

  lifecycle {
    postcondition {
      condition     = can(cidrnetmask("${self.ip_address}/32"))
      error_message = "The Traefik public IP must have an assigned IPv4 address for the Stats A record."
    }
  }
}
