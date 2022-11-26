data "github_repository" "teamdman_content" {
  full_name = "teamdman-ca/site-content"
}

locals {
  secrets = {
    service_principal_creds = jsonencode({
      clientId                   = azuread_application.site_deployer.application_id
      clientSecret               = azuread_application_password.site_deployer_password.value
      tenantId                   = data.azuread_client_config.current.tenant_id
      subscriptionId             = data.azurerm_client_config.current.subscription_id
      resourceManagerEndpointUrl = "https://management.azure.com/"
    })
    resource_group_name    = azurerm_resource_group.main.name
    storage_account_name   = azurerm_storage_account.main.name
    storage_container_name = azurerm_storage_container.web.name
    # cdn_profile_name     = azurerm_cdn_profile.main.name
    # cdn_endpoint_name    = azurerm_cdn_endpoint.root.name
  }
}

resource "github_actions_organization_secret" "cicd" {
  for_each                = local.secrets
  selected_repository_ids = [data.github_repository.teamdman_content.repo_id]
  secret_name             = each.key
  visibility              = "selected"
  plaintext_value         = each.value
}
