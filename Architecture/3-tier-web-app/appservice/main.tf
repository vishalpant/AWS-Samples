resource "azurerm_service_plan" "this" {
  name                   = var.asp_name
  location               = var.location
  os_type                = var.os_type
  resource_group_name    = var.resource_group_name
  sku_name               = var.sku_name
  zone_balancing_enabled = var.zone_balancing_enabled
  worker_count           = var.worker_count
}

resource "azurerm_linux_web_app" "this" {
  name                          = var.web_app_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  service_plan_id               = azurerm_service_plan.this.id
  https_only                    = var.https_only
  public_network_access_enabled = var.public_network_access_enabled
  virtual_network_subnet_id     = var.vnet_integration_required ? var.vnet_integration_subnet_id : null
  site_config {
    dynamic "ip_restriction" {
      for_each = var.allowed_subnet != "" ? [1] : []
      content {
        action                    = "Allow"
        virtual_network_subnet_id = var.allowed_subnet
      }
    }
  }
}

resource "azurerm_private_endpoint" "this" {
  count               = var.private_endpoint_required ? 1 : 0
  name                = "${azurerm_linux_web_app.this.name}-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.app_subnet_id

  private_service_connection {
    name                           = "${azurerm_linux_web_app.this.name}-service-connection"
    private_connection_resource_id = azurerm_linux_web_app.this.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = var.private_dns_zone
    private_dns_zone_ids = [var.private_dns_zone_id]
  }
}
