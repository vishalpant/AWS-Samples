resource "random_integer" "this" {
  min = 50
  max = 2000
  keepers = {
    application_name = var.application_name
  }
}

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = var.location
}

module "vnet" {
  source              = "./vnet"
  vnet_name           = local.vnet_name
  resource_group_name = local.resource_group_name
  vnet_address_space  = var.vnet_address_space
  location            = var.location
  subnets             = var.subnets
}

module "dns_zone" {
  source              = "./dns"
  resource_group_name = local.resource_group_name
  private_dns_zones   = local.private_dns_zones
}

module "database" {
  source                        = "./database"
  sql_server_name               = local.sql_server_name
  sql_db_name                   = local.sql_db_name
  resource_group_name           = local.resource_group_name
  location                      = var.location
  sql_version                   = var.sql_version
  public_network_access_enabled = var.sql_public_network_access_enabled
  app_subnet_id                 = module.vnet.subnet_ids["webapp"]
  db_subnet_id                  = module.vnet.subnet_ids["db"]
  private_dns_zone_id           = module.dns_zone.private_dns_zone_ids["privatelink.database.windows.net"]
  private_dns_zone              = "privatelink.database.windows.net"
}

module "webapp" {
  source                        = "./appservice"
  worker_count                  = 3
  zone_balancing_enabled        = true
  resource_group_name           = local.resource_group_name
  location                      = var.location
  asp_name                      = local.web_app_asp_name
  web_app_name                  = local.web_app_app_name
  os_type                       = "Linux"
  sku_name                      = "P1v2"
  https_only                    = true
  public_network_access_enabled = true
  vnet_integration_required     = false
  private_endpoint_required     = false
}

module "api" {
  source                        = "./appservice"
  worker_count                  = 3
  zone_balancing_enabled        = true
  resource_group_name           = local.resource_group_name
  location                      = var.location
  asp_name                      = local.api_asp_name
  web_app_name                  = local.api_app_name
  os_type                       = "Linux"
  sku_name                      = "P1v2"
  https_only                    = true
  public_network_access_enabled = false
  allowed_subnet               = module.vnet.subnet_ids["apim"]
  vnet_integration_required     = true
  vnet_integration_subnet_id    = module.vnet.subnet_ids["api"]
  private_endpoint_required     = true
  private_dns_zone              = "privatelink.azurewebsites.net"
  private_dns_zone_id           = module.dns_zone.private_dns_zone_ids["privatelink.azurewebsites.net"]
  app_subnet_id                 = module.vnet.subnet_ids["api"]
}