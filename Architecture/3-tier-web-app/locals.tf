locals {
  resource_group_name = "${var.application_name}-rg"
  sql_server_name     = "${var.application_name}-${random_integer.this.result}-sql-server"
  sql_db_name         = "${var.application_name}-sql-db"
  vnet_name           = "${var.application_name}-vnet"
  web_app_asp_name    = "${var.application_name}-web-asp"
  web_app_app_name    = "${var.application_name}-web-app"
  api_app_name        = "${var.application_name}-api-app"
  api_asp_name        = "${var.application_name}-api-asp"
  private_dns_zones = [
    {
      "private_dns_zone" = "privatelink.database.windows.net"
      "vnets" = [{
        id   = module.vnet.vnet_id
        name = local.vnet_name
      }]
    },
    {
      "private_dns_zone" = "azure-api.net"
      "vnets" = [{
        id   = module.vnet.vnet_id
        name = local.vnet_name
      }]
    },
    {
      "private_dns_zone" = "privatelink.azurewebsites.net"
      "vnets" = [{
        id   = module.vnet.vnet_id
        name = local.vnet_name
      }]
    }
  ]
}