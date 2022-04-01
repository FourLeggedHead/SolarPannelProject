# Create resource group
resource "azurerm_resource_group" "solarpanel_rg" {
  name = "SOLAR-PANEL-${upper(var.env)}-001-RG"
  location = "West Europe"
  tags = {
      Environment = upper(var.env)
  }
}

# Create IoT hub