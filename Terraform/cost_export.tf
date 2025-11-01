
resource "azurerm_subscription_cost_management_export" "cost_export" {
  name                         = "daily-cost-export"
  subscription_id              = format("/subscriptions/%s", data.azurerm_client_config.current.subscription_id)
  recurrence_type              = "Daily"
  recurrence_period_start_date = "${formatdate("2025-11-01", timestamp())}T00:00:00Z"
  recurrence_period_end_date   = "2025-12-01T00:00:00Z"

  export_data_options {
    type       = "ActualCost"
    time_frame = "MonthToDate"
  }

  export_data_storage_location {
    container_id     = azurerm_storage_container.exports.id
    root_folder_path = "cost-exports"
  }
}
