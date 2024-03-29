resource "azurerm_dns_zone" "main" {
  resource_group_name = azurerm_resource_group.main.name
  name                = "teamdman.ca"
}

# resource "azurerm_dns_a_record" "root" {
#   resource_group_name = azurerm_resource_group.main.name
#   zone_name           = azurerm_dns_zone.main.name
#   name                = "@"
#   ttl                 = 30
#   target_resource_id  = azurerm_cdn_endpoint.root.id
# }

## this doesn't work because of https, need a gateway or cdn endpoint
# locals {
#   host_name = regex("^https://(.*)/$", azurerm_storage_account.main.primary_web_endpoint)[0]
# }
# resource "azurerm_dns_cname_record" "root" {
#   resource_group_name = azurerm_resource_group.main.name
#   zone_name           = azurerm_dns_zone.main.name
#   name                = "@"
#   ttl                 = 30
#   # record              = azurerm_storage_account.main.primary_web_endpoint
#   record              = local.host_name
# }

resource "azurerm_dns_cname_record" "awverify" {
  resource_group_name = azurerm_resource_group.main.name
  zone_name           = azurerm_dns_zone.main.name
  name                = "awverify"
  ttl                 = 30
  record              = "awverify.teamdman.ca.azurewebsites.net"
}
resource "azurerm_dns_cname_record" "awverifywww" {
  resource_group_name = azurerm_resource_group.main.name
  zone_name           = azurerm_dns_zone.main.name
  name                = "awverify.www"
  ttl                 = 30
  record              = "awverify.teamdman.ca.azurewebsites.net"
}

# resource "azurerm_dns_cname_record" "cdnverify" {
#   resource_group_name = azurerm_resource_group.main.name
#   zone_name           = azurerm_dns_zone.main.name
#   name                = "cdnverify"
#   ttl                 = 3600
#   record              = "cdnverify.ca-teamdman.azureedge.net"
# }

resource "azurerm_dns_cname_record" "wwww" {
  resource_group_name = azurerm_resource_group.main.name
  zone_name           = azurerm_dns_zone.main.name
  name                = "wwww"
  ttl                 = 30
  record              = "teamdman.ca.azurewebsites.net"
}

resource "azurerm_role_assignment" "dns" {
  principal_id         = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  scope                = azurerm_dns_zone.main.id
  role_definition_name = "DNS Zone Contributor"
}