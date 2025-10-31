
# ensure client config is declared so we can build the subscription path
data "azurerm_client_config" "current" {}

resource "azurerm_consumption_budget_subscription" "cost_budget" {
  name            = "monthly-cost-budget"
  # provider expects full subscription path "/subscriptions/<uuid>"
  subscription_id = format("/subscriptions/%s", data.azurerm_client_config.current.subscription_id)
  amount          = 50
  time_grain      = "Monthly"

  time_period {
    start_date = "2025-10-01T00:00:00Z"
    end_date   = "2025-11-13T00:00:00Z"
  }

  notification {
    enabled        = true
    threshold      = 90
    operator       = "GreaterThan"
    contact_emails = ["skuanar1992@hotmail.com"]
    contact_roles  = ["Owner"]
  }
}
 
