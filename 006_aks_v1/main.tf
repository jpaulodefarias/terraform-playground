terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.51"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = ">=1.4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {}
