# Get the provider's configuration
data "azurerm_client_config" "current" {  
}

# Creates the key vault
resource "azurerm_key_vault" "solarpanel_kv" {
    name = "solarpanel${lower(var.env)}001kv"
    location = var.loc
    resource_group_name = var.rg
    sku_name = "standard"
    tenant_id = data.azurerm_client_config.current.tenant_id

    tags = {
      Environment = upper(var.env)
  }
}