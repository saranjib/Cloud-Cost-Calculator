resource "azurerm_monitor_action_group" "alert-ag" {
  name                = "CostAlerts"
  resource_group_name = azurerm_resource_group.cost-rg.name
  short_name          = "costalert"

  email_receiver {
    name          = "Email"
    email_address = "skuanar1992@hotmail.com"
  }
}

resource "azurerm_monitor_metric_alert" "cost_spike" {
  name                = "cost-spike-alert"
  resource_group_name = azurerm_resource_group.cost-rg.name
  scopes              = [azurerm_servicebus_namespace.cost-servicebus.id]
  description         = "Service Bus topic — incoming messages spike"
  severity            = 2
  enabled             = true

  criteria {
   metric_namespace = "Microsoft.ServiceBus/namespaces/topics"
    metric_name      = "IncomingMessages"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 20
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert-ag.id
  }
}
