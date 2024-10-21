variable "location" {
  type        = string
  description = "Location where resource should be placed"
}

variable "rg_name" {
  type        = string
  description = "Name of parent resource group"
}

variable "sa_01_name" {
  type        = string
  description = "Name of the storage account"
}

variable "sc_01_name" {
  type        = string
  description = "Name of the storage container "
}