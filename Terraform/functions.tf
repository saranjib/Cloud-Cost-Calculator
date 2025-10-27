resource "azurerm_service_plan" "cost_plan" {
  name                = "cost-app-service-plan"
  resource_group_name = azurerm_resource_group.cost-rg.name
  location            = azurerm_resource_group.cost-rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}


resource "azurerm_linux_function_app" "func_app" {
  name                       = "cloud-cost-calculator-func1"
  location                   = azurerm_resource_group.cost-rg.location
  resource_group_name        = azurerm_resource_group.cost-rg.name
  service_plan_id            = azurerm_service_plan.cost_plan.id
  storage_account_name       = azurerm_storage_account.cost_sa.name
  storage_account_access_key = azurerm_storage_account.cost_sa.primary_access_key

  identity {
    type = "SystemAssigned"
  }

  site_config {
    # python_version = "3.9"  # optionally
    ftps_state = "Disabled"
  }

app_settings = {
    FUNCTIONS_EXTENSION_VERSION = "~4"
    FUNCTIONS_WORKER_RUNTIME    = "python"
    AzureWebJobsStorage         = azurerm_storage_account.cost_sa.primary_connection_string
    SERVICEBUS_TOPIC_NAME       = azurerm_servicebus_topic.notifications.name
    SERVICEBUS_NAMESPACE        = azurerm_servicebus_namespace.cost-servicebus.name
    # Use Key Vault or Managed Identity in production to fetch secrets
  }
}

