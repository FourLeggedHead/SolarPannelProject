# Create resource group
resource "azurerm_resource_group" "solarpanel_rg" {
  name = "SOLAR-PANEL-${upper(var.env)}-001-RG"
  location = "West Europe"
  tags = {
      Environment = upper(var.env)
  }
}

# Create IoT hub
resource "azurerm_iothub" "solarpanel_iot" {
  name = "SOLAR-PANEL-${upper(var.env)}-001-IOT"
  resource_group_name = azurerm_resource_group.solarpanel_rg.name
  location = azurerm_resource_group.solarpanel_rg.location
  sku {
    name = "F1"
    capacity = "1"
  }
  tags = {
      Environment = upper(var.env)
  }

  depends_on = [
    azurerm_resource_group.solarpanel_rg
  ]
}