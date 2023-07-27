variable "resource_group_name" {
  type        = string
  description = "The name of the resource group inside which the app service will be created."
}

variable "location" {
  type        = string
  description = "Location where App serivice plan and app service will be created."
}

variable "asp_name" {
  type        = string
  description = "Name of the App Service Plan"
}

variable "web_app_name" {
  type        = string
  description = "Name of the Web app"
}

variable "os_type" {
  type        = string
  description = "OS type to be used"
}

variable "sku_name" {
  type        = string
  description = "SKU to be used to create App service plan"
}

variable "zone_balancing_enabled" {
  type        = bool
  description = "true if zone redundancy is required else false"
}

variable "worker_count" {
  type        = number
  description = "The number of Workers (instances) to be allocated."
}

variable "https_only" {
  type        = bool
  description = "Should the Linux Web App require HTTPS connections."
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Should public network access be enabled for the Web App."
}

variable "allowed_subnet" {
  type        = string
  description = "Subnet ID that need to be allowed on web app"
  default = ""
}

variable "vnet_integration_required" {
  type        = bool
  description = "Whether VNet integration should be enabled"
}

variable "vnet_integration_subnet_id" {
  type        = string
  description = "ID of subnet for VNet integration"
  default     = ""
}

variable "private_dns_zone" {
  type        = string
  description = "Name of the private DNS zone where DNS record need to be created."
  default     = ""
}

variable "private_dns_zone_id" {
  type        = string
  description = "ID of the private DNS zone where DNS record need to be created."
  default     = ""
}

variable "app_subnet_id" {
  type        = string
  description = "ID of the app subnet"
  default     = ""
}

variable "private_endpoint_required" {
  type        = bool
  description = "Whether Private Endpoint needs to be created"
}