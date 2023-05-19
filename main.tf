terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.40.0"
    }
  }
  backend "azurerm" {
    storage_account_name = "strglobaltfstate"
    container_name       = "iaac-test"
    key                  = "iaac-test.terraform.tfstate"
    use_azuread_auth     = true
    subscription_id      = "6a3eabb6-0b94-42a4-afaa-23ff6af2f982"
    tenant_id            = "e4eb2309-e755-4f0c-89ac-081cf3d84440"
  }
}

provider "azurerm" {
  subscription_id = "cd4be4d3-db8d-4843-b728-09f8abcb6f90"
  features {}
}

locals {
  subid    = "cd4be4d3-db8d-4843-b728-09f8abcb6f90"
  location = "eastus"
}

resource "azurerm_resource_group" "rg-test" {
  name = "rg-test"
  location = local.location
}

resource "azurerm_virtual_network" "my_terraform_network" {
  name                = "test-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = local.location
  resource_group_name = azurerm_resource_group.rg-test.name
}


