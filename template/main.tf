{{warning_header}}
terraform {
  backend "azurerm" {
    resource_group_name  = "Terraform"
    storage_account_name = "terraform9201"
    container_name       = "tfstate"
    key                  = "mykubernetes.tfstate"
    subscription_id      = "{{subscription_id}}"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.34.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.31.0"
    }
    github = {
      source  = "integrations/github"
      version = ">=4.26.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.4.3"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "{{subscription_id}}"
}

data "azurerm_client_config" "current" {

}

data "azuread_client_config" "current" {

}
