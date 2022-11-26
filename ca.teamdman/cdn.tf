# resource "azurerm_cdn_profile" "main" {
#   resource_group_name = azurerm_resource_group.main.name
#   location            = "canadaeast"
#   sku                 = "Standard_Microsoft"
#   name                = "ca-teamdman"
# }

# locals {
#   host_name = regex("^https://(.*)/$", azurerm_storage_account.main.primary_web_endpoint)[0]
# }

# resource "azurerm_cdn_endpoint" "root" {
#   resource_group_name = azurerm_cdn_profile.main.resource_group_name
#   profile_name        = azurerm_cdn_profile.main.name
#   location            = "canadaeast"
#   name                = "ca-teamdman"
#   origin {
#     name      = "origin1"
#     host_name = local.host_name
#   }
#   origin_host_header = local.host_name

#   delivery_rule {
#     name  = "httpsredirect"
#     order = 1

#     request_scheme_condition {
#       match_values = [
#         "HTTP",
#       ]
#       negate_condition = false
#       operator         = "Equal"
#     }

#     url_redirect_action {
#       protocol      = "Https"
#       redirect_type = "PermanentRedirect"
#     }
#   }

#   lifecycle {
#     ignore_changes = [origin, is_compression_enabled]
#   }
# }

# resource "azurerm_cdn_endpoint_custom_domain" "root" {
#   cdn_endpoint_id = azurerm_cdn_endpoint.root.id
#   name            = "teamdman-ca"
#   host_name       = "teamdman.ca"
#   user_managed_https {
#     key_vault_certificate_id = "https://ca-teamdman.vault.azure.net/certificates/teamdman-ca"
#   }
#   depends_on = [
#     azurerm_dns_a_record.root
#   ]
# }

# resource "azurerm_role_assignment" "cdn_purge" {
#   principal_id         = azuread_service_principal.site_deployer.object_id
#   scope                = azurerm_cdn_endpoint.root.id
#   role_definition_name = "CDN Endpoint Contributor"
# }