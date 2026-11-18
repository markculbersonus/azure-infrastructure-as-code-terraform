terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 5.0.0"
    }
  }
}

# Supply the subscription ID through ARM_SUBSCRIPTION_ID or another supported method.
provider "azurerm" {
  features {}
}
