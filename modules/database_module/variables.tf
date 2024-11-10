variable "location" {
  type        = string
  description = "Location where resource should be placed"
}

variable "rg_name" {
  type        = string
  description = "Name of parent resource group"
}

variable "sql_server_base_name" {
  type        = string
  description = "Name of the sql server"
}

variable "db_base_name" {
  type        = string
  description = "Name of the database resource"
}