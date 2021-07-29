terraform {
  backend "azurerm" {
    resource_group_name  = "takai-tfstate"
    storage_account_name = "tfstate22053"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "rg" {
  name     = "takai-terraform-test"
  location = "japaneast"
}
resource "azurerm_virtual_network" "vn" {
  name                = "vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/8"]
}

resource "azurerm_subnet" "sn" {
  name                 = "subnet"
  virtual_network_name = azurerm_virtual_network.vn.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["10.1.0.0/16"]
}
