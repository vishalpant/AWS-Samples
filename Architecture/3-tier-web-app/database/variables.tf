variable "sql_server_name" {
  type        = string
  description = "The name of the Microsoft SQL Server. This needs to be globally unique within Azure."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group inside which the SQL resources will be created."
}

variable "location" {
  type        = string
  description = "Location where SQL resources will be created"
}

variable "sql_version" {
  type        = string
  description = "The version for the new server"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "true if public network access needs to be enabled else false"
}

variable "app_subnet_id" {
  type        = string
  description = "ID of the subnet containing the web application"
}

variable "db_subnet_id" {
  type        = string
  description = "ID of the DB subnet"
}

variable "sql_db_name" {
  type        = string
  description = "Name of the SQL DB"
}

variable "private_dns_zone" {
  type        = string
  description = "Name of the private DNS zone where DNS record need to be created."
}

variable "private_dns_zone_id" {
  type        = string
  description = "ID of the private DNS zone where DNS record need to be created."
}