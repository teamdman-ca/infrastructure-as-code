resource "azurerm_dns_zone" "main" {
  resource_group_name = azurerm_resource_group.main.name
  name                = "teamdman.ca"
}

resource "azurerm_dns_a_record" "root" {
  resource_group_name = azurerm_resource_group.main.name
  zone_name           = azurerm_dns_zone.main.name
  name                = "@"
  ttl                 = 30
  target_resource_id  = azurerm_cdn_endpoint.root.id
}
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

resource "azurerm_dns_cname_record" "cdnverify" {
  resource_group_name = azurerm_resource_group.main.name
  zone_name           = azurerm_dns_zone.main.name
  name                = "cdnverify"
  ttl                 = 3600
  record              = "cdnverify.ca-teamdman.azureedge.net"
}

resource "azurerm_dns_cname_record" "wwww" {
  resource_group_name = azurerm_resource_group.main.name
  zone_name           = azurerm_dns_zone.main.name
  name                = "wwww"
  ttl                 = 30
  record              = "teamdman.ca.azurewebsites.net"
}