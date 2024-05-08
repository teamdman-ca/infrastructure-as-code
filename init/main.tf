provider "azurerm" {
  features {}
  subscription_id = "6cb7032f-2437-4f5e-91e8-676cb67e5444"
}

resource "azurerm_resource_group" "main" {
  name     = "CACN-Terraform-PROD-RG"
  location = "canadacentral"
  tags = {
    environment = "Production"
  }
}

resource "random_string" "suffix" {
  special = false
  upper   = false
  length  = 6
}

data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

resource "azurerm_storage_account" "main" {
  name                          = "terraformprod${random_string.suffix.result}"
  resource_group_name           = azurerm_resource_group.main.name
  location                      = azurerm_resource_group.main.location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  tags                          = azurerm_resource_group.main.tags
  network_rules {
    default_action = "Deny"
    # bypass = [
    #     "${chomp(data.http.myip.response_body)}/32"
    # ]
    ip_rules = [
      "${chomp(sensitive(data.http.myip.response_body))}"
    ]
  }
}

resource "azurerm_storage_container" "main" {
  name                 = "statefiles"
  storage_account_name = azurerm_storage_account.main.name
}

output "storage_account_name" {
  value = azurerm_storage_account.main.name
}
