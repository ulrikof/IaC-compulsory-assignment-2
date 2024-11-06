variable "location" {
  type        = string
  description = "Location where resource should be placed"
}

variable "rg_name" {
  type        = string
  description = "Name of parent resource group"
}

variable "vnet_name" {
  type        = string
  description = "Name of the vnet"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "nsg_01_name" {
  type        = string
  description = "Name of the NSG"
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the vnet"
}

variable "address_prefixes" {
  type        = list(string)
  description = "Address prefixes for the subnet"
}


