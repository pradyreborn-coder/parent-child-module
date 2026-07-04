terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.76.0"
    }
  }

backend "azurerm" {
  resource_group_name  = "rg-prady-g"
  storage_account_name = "sapradyg"
  container_name       = "container"
  key                  = "terraform.tfstate"
}
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  
}
}

