resource "azurerm_cdn_profile" "main" {
  resource_group_name = azurerm_resource_group.main.name
  location            = "canadaeast"
  sku                 = "Standard_Microsoft"
  name                = "ca-teamdman"
}

locals {
    host_name = regex("^https://(.*)/$",azurerm_storage_account.site.primary_web_endpoint)[0]
}

resource "azurerm_cdn_endpoint" "teamdmanca" {
  resource_group_name = azurerm_cdn_profile.main.resource_group_name
  profile_name        = azurerm_cdn_profile.main.name
  location            = "canadaeast"
  name                = "ca-teamdman"
  origin {
    name      = "origin1"
    host_name = local.host_name
  }
  origin_host_header = local.host_name

  delivery_rule {
    name  = "httpsredirect"
    order = 1

    request_scheme_condition {
      match_values = [
        "HTTP",
      ]
      negate_condition = false
      operator         = "Equal"
    }

    url_redirect_action {
      protocol      = "Https"
      redirect_type = "PermanentRedirect"
    }
  }

    lifecycle {
      ignore_changes = [origin]
    }
}
