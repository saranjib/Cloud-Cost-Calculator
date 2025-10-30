variable "resource_group_location" {
  type        = string
  default     = "West Europe"
  description = "Location of the resource group."
}

variable "storage_account_name" {
  type        = string
  default     = "costsa12345"
  description = "Name of the storage account for cost exports and reports."
}

variable "app_service_plan" {
  description = "app_service_plan for resource names"
  type        = string
  default     = "costapp"
}

