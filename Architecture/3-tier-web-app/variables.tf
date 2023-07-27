variable "application_name" {
  type        = string
  description = "The Name application which will be used as a prefix."
}

variable "location" {
  type        = string
  description = "The Azure Region where the resources should exist."
}

variable "sql_version" {
  type        = string
  description = "The version for the new SQL server"
}

variable "sql_public_network_access_enabled" {
  type        = string
  description = "true if public network access needs to be enabled on SQL server else false"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "List of CIDR ranges allocated to VNet"
}

variable "subnets" {
  type = list(object({
    name             = string,
    address_prefixes = list(string),
    delegation = list(object({
      name               = string,
      service_delegation = string
    }))
  }))
  description = "List of subnets to be created in VNet"
}