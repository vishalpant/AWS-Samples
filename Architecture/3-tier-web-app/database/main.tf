resource "random_password" "this" {
  length           = 16
  special          = true
  override_special = "!#$%"
  keepers = {
    username        = local.sql_server_admin_user
    sql_server_name = var.sql_server_name
  }
}

resource "azurerm_user_assigned_identity" "this" {
  name                = local.managed_identity_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_mssql_server" "this" {
  name                              = var.sql_server_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  public_network_access_enabled     = var.public_network_access_enabled
  primary_user_assigned_identity_id = azurerm_user_assigned_identity.this.id
  administrator_login               = local.sql_server_admin_user
  administrator_login_password      = random_password.this.result
  connection_policy                 = "Proxy"
  version                           = var.sql_version

  azuread_administrator {
    login_username = azurerm_user_assigned_identity.this.name
    object_id      = azurerm_user_assigned_identity.this.principal_id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }
}

resource "azurerm_mssql_virtual_network_rule" "this" {
  name      = local.app_subnet_traffic_rule
  server_id = azurerm_mssql_server.this.id
  subnet_id = var.app_subnet_id
}

resource "azurerm_mssql_database" "this" {
  name      = var.sql_db_name
  server_id = azurerm_mssql_server.this.id
}

resource "azurerm_private_endpoint" "this" {
  name                = "${azurerm_mssql_server.this.name}-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.db_subnet_id

  private_service_connection {
    name                           = "${azurerm_mssql_server.this.name}-service-connection"
    private_connection_resource_id = azurerm_mssql_server.this.id
    is_manual_connection           = false
    subresource_names              = ["mysqlServer"]
  }

  private_dns_zone_group {
    name                 = var.private_dns_zone
    private_dns_zone_ids = [var.private_dns_zone_id]
  }
}