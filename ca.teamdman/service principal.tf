resource "azuread_application" "site_deployer" {
  display_name = "github_cicd_pipeline"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_application_password" "site_deployer_password" {
  application_object_id = azuread_application.site_deployer.object_id
}
output "service_principal_password" {
  sensitive = true
  value     = azuread_application_password.site_deployer_password.value
}


resource "azuread_service_principal" "site_deployer" {
  application_id = azuread_application.site_deployer.application_id
  owners         = azuread_application.site_deployer.owners
}
