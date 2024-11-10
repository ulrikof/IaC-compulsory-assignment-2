variable "location" {
  type        = string
  description = "Location where resource should be placed"
}

variable "rg_name" {
  type        = string
  description = "Name of parent resource group"
}

variable "service_plan_name" {
  type        = string
  description = "Name of the service plan"
}

variable "service_plan_sku" {
  type        = string
  description = "sku for the service plan"
}

