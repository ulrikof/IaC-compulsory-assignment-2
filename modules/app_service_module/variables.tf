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

variable "app_service_name" {
  type        = string
  description = "Name of the app service"
}

variable "sa_name" {
  type        = string
  description = "The name of the storage account that the app service uses for blob storage"
}

variable "sa_access_key" {
  type        = string
  description = "Access key for the storage account that the app service uses for blob storage"
}

variable "sc_name" {
  type        = string
  description = "The name of the storage container that the app service uses for blob storage"
}


