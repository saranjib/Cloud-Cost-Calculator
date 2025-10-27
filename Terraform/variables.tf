variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "storage_account_name" {
  type        = string
  default     = "costsa12345"
  description = "Name of the storage account for cost exports and reports."
}
