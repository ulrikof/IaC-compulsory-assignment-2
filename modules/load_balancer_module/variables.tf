variable "location" {
  type        = string
  description = "Location where resource should be placed"
}

variable "rg_name" {
  type        = string
  description = "Name of parent resource group"
}

variable "public_ip_name" {
  type        = string
  description = "Name of the public ip address"
}

variable "lb_name" {
  type        = string
  description = "Name of the load balancer"
}