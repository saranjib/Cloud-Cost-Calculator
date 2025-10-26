resource "azurerm_resource_group" "cost-rg" {
  name     = var.cost-project-rg_name
  location = var.location
}

# Storage account for cost exports, reports, and static website dashboard
resource "azurerm_storage_account" "cost_sa" {
  name                     = lower(replace(var.storage_account_name, "/[^a-z0-9]/", ""))
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = false
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