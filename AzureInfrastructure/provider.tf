# Set Azure provider source and version
terraform {
  required_providers {
    azurem = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurem" {
  features{}
}