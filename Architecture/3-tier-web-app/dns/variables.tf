variable "resource_group_name" {
  type        = string
  description = "The name of the resource group inside which the SQL resources will be created."
}

variable "private_dns_zones" {
  type = list(object({
    private_dns_zone = string,
    vnets = list(object({
      name = string,
      id   = string
    }))
  }))
  description = "List of private DNS zones and VNets for creating the links."
}