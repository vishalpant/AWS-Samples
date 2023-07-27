variable "vnet_name" {
  type        = string
  description = "Name of the VNet that needs to be created"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group under which resources will be created"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Name of the resource group under which resources will be created"
}

variable "location" {
  type        = string
  description = "Location where SQL resources will be created"
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