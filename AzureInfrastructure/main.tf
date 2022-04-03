# Create resource group
resource "azurerm_resource_group" "solarpanel_rg" {
  name = "SOLAR-PANEL-${upper(var.env)}-001-RG"
  location = "West Europe"
  tags = {
      Environment = upper(var.env)
  }
}

# Create Storage Account
resource "azurerm_storage_account" "solarpanel_sa" {
  name = "solarpanel${lower(var.env)}001sa"
  resource_group_name = azurerm_resource_group.solarpanel_rg.name
  location = azurerm_resource_group.solarpanel_rg.location
  account_kind = "BlobStorage"
  account_tier = "Standard"
  account_replication_type = "LRS"
  tags = {
      Environment = upper(var.env)
  }
}

# Create Container
resource "azurerm_storage_container" "solarpanel_sc" {
  name = "raw"
  storage_account_name = azurerm_storage_account.solarpanel_sa.name  
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

  endpoint {
    type = "AzureIotHub.StorageContainer"
    name = "dataLogging"
    connection_string = azurerm_storage_account.solarpanel_sa.primary_blob_connection_string
    container_name = azurerm_storage_container.solarpanel_sc.name
    encoding = "Avro"
    file_name_format = "{iothub}/{partition}_{YYYY}_{MM}_{DD}_{HH}_{mm}"    
  }

  tags = {
      Environment = upper(var.env)
  }

  depends_on = [
    azurerm_resource_group.solarpanel_rg,
    azurerm_storage_container.solarpanel_sc
  ]
}