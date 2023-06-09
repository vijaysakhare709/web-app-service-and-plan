terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "example" {
  name     = "api-rg-pro"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "hello" {
  name                = "api-appserviceplan-pro-vijay"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_linux_web_app" "hello1" {
  name                = "vijay-tt-yy-s"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  service_plan_id     = azurerm_app_service_plan.hello.id

  site_config {
  }

depends_on = [
    azurerm_app_service_plan.hello
]
}

# deployment slot
resource "azurerm_linux_web_app_slot" "exambbple" {
  name           = "example-vvkj-slot"
  app_service_id = azurerm_linux_web_app.hello1.id

  site_config {}

depends_on =  [
    azurerm_app_service_plan.hello
]

}


resource "azurerm_app_service_active_slot" "example" {
  resource_group_name   = azurerm_resource_group.example.name
  app_service_name      = azurerm_linux_web_app.hello1.name
  app_service_slot_name = azurerm_linux_web_app_slot.exambbple.name
  
}


