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

variable "sql_server_admin_login" {
  type = string
  description = "Username of admin login on the SQL server"
}

variable "sql_server_admin_password" {
  type = string
    description = "Password of admin login on the SQL server"
}

variable "db_sku" {
  type = string
  description = "SKU of the database"
}

variable "db_max_gb" {
  type = number
  description = "Max gb of the database"
}