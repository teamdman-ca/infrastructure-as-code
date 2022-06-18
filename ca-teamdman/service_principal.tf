resource "azuread_application" "site_deployer" {
  display_name = "github_cicd_pipeline"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_application_password" "site_deployer_password" {
  application_object_id = azuread_application.site_deployer.object_id
}


resource "azuread_service_principal" "site_deployer" {
  application_id = azuread_application.site_deployer.application_id
  owners         = azuread_application.site_deployer.owners
}

resource "azurerm_role_assignment" "site_write" {
  principal_id         = azuread_service_principal.site_deployer.object_id
  scope                = azurerm_storage_account.site.id
  role_definition_name = "Storage Blob Data Contributor"
}
