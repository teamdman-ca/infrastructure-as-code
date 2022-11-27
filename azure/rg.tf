resource "azurerm_resource_group" "main" {
  name     = "ca.teamdman"
  location = "canadaeast"
  tags = {
    "Web-Domain" = "teamdman.ca"
    "Web-FQDN"   = "teamdman.ca"
  }
}