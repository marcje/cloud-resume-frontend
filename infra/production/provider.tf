terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
  backend "azurerm" {
      resource_group_name  = "mtb-p-cv-frontend-tfstate-rg"
      storage_account_name = "mtbpcvfrontendtfstatest"
      container_name       = "terraform-state"
      key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  tenant_id  = var.tenant_id
  subscription_id = var.subscription_id
  features {}
}
