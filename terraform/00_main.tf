terraform {
  required_version = ">= 0.12"
  backend "azurerm" {
    storage_account_name = "storageaccountmsdetfm"
    container_name       = "terraform"
    key                  = "terraform.tfstate"
    resource_group_name  = "rgmsdetfm"
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  version         = "~> 2.2.0"
  features {}
}

data "azurerm_resource_group" "rg" {
  name = var.rg
}

data "azurerm_client_config" "current" {
}

data "azurerm_storage_account" "storage_account" {
  name                = "storageaccountmsdetfm"
  resource_group_name = "rgmsdetfm"
}
