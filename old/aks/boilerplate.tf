terraform {
  backend "azurerm" {
    resource_group_name  = "Terraform"
    storage_account_name = "terraform9201"
    container_name       = "tfstate"
    key                  = "ca.teamdman.tfstate"
    # subscription_id = ""
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.77.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.44.1"
    }
    github = {
      source  = "integrations/github"
      version = ">=5.40.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.5.1"
    }
  }
}

locals {
  dotenv = { for tuple in regexall("(.*)=(.*?)\\s*", file(".env")) : tuple[0] => tuple[1] }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

provider "github" {
  owner = "teamdman-ca"
  token = local.dotenv.github_token
}

data "azurerm_client_config" "current" {

}

data "azuread_client_config" "current" {

}