resource "azurerm_servicebus_namespace" "cost-servicebus" {
  name                = "cost-servicebus-ns"
  location            = azurerm_resource_group.cost-rg.location
  resource_group_name = azurerm_resource_group.cost-rg.name
  sku                 = "Standard"
}

resource "azurerm_servicebus_topic" "notifications" {
  name                = "notifications"
  namespace_id = azurerm_servicebus_namespace.cost-servicebus.id
}

# subscription for email/sms/voice consumers or filtered subscriptions
resource "azurerm_servicebus_subscription" "email_sub" {
  name                = "email-sub"
  topic_id            = azurerm_servicebus_topic.notifications.id
  max_delivery_count  = 10
}
