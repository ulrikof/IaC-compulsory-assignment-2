variable "sql_server_admin_login" {
  type        = string
  description = "Username of admin login on the SQL server"
}

variable "sql_server_admin_password" {
  type        = string
  description = "Password of admin login on the SQL server"
}

variable "db_sku" {
  type        = string
  description = "SKU of the database"
}

variable "db_max_gb" {
  type        = number
  description = "Max gb of the database"
}

variable "service_plan_sku" {
  type = string
  description = "sku for the service plan"
}
