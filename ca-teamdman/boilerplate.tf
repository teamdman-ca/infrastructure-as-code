terraform {
  backend "azurerm" {
    resource_group_name  = "Terraform"
    storage_account_name = "terraform9201"
    container_name       = "tfstate"
    key                  = "ca.teamdman.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.10.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {
  
}