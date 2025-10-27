resource "azurerm_resource_group" "cost-rg" {
  name     = "cost-rg_name"
  location = var.resource_group_location
}

# Storage account for cost exports, reports, and static website dashboard
resource "azurerm_storage_account" "cost_sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.cost-rg.name
  location                 = azurerm_resource_group.cost-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# enable static website for dashboard (container $web)
resource "azurerm_storage_account_static_website" "static" {
  storage_account_id = azurerm_storage_account.cost_sa.id
  index_document     = "index.html"
  error_404_document = "404.html"
}

# containers for cost exports and reports
resource "azurerm_storage_container" "exports" {
  name                  = "cost-exports"
  storage_account_name  = azurerm_storage_account.cost_sa.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "reports" {
  name                  = "cost-reports"
  storage_account_name  = azurerm_storage_account.cost_sa.name
  container_access_type = "private"
}

