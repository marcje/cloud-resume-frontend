variable "default_location" {
  type        = string
  description = "Default location for resources."
  default     = "westeurope"
}

variable "default_prefix" {
  type        = string
  description = "Default prefix for resources."
}

variable "storage_account_name" {
  type        = string
  description = "Storage account name - historically different naming convention."
}

variable "tenant_id" {
  type        = string
  sensitive   = true
  description = "Microsoft Azure tenant ID"
}

variable "subscription_id" {
  type        = string
  sensitive   = true
  description = "Microsoft Azure subscription ID"
}

variable "resource_group_budget_amount" {
  type        = string
  description = "Parent resource group budget amount"
}

variable "resource_group_budget_time" {
  type        = string
  description = "Parent resource group budget time grain"
  default     = "Monthly"
}

variable "resource_group_budget_contact_emails" {
  type        = list(string)
  sensitive   = true
  description = "Parent resource group budget contact emails"
}

variable "resource_group_budget_start" {
  type        = string
  description = "Parent resource group budget start date"
}

variable "resource_group_budget_end" {
  type        = string
  description = "Parent resource group budget end date"
}

variable "resource_group_budget_actual_threshold" {
  type        = string
  description = "Parent resource group budget - percentage to notify on actual reached threshold"
}

variable "resource_group_budget_forecast_threshold" {
  type        = string
  description = "Parent resource group budget - percentage to notify on forecasted threshold"
}

variable "storage_account_replication_type" {
  type        = string
  description = "Storage account replication type"
}

variable "cdne_domain" {
  type        = string
  description = "Custom domain for the CDN endpoint"
}

variable "azure_function_url" {
  type        = string
  sensitive   = true
  description = "URL for the Azure function running the backend code"
}
