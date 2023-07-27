resource "azurerm_private_dns_zone" "this" {
  for_each            = toset([for zone in var.private_dns_zones : zone.private_dns_zone])
  name                = each.value
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each              = { for zone in local.dns_zone_vnet_link : "${zone.zone}-${zone.vnet_name}" => zone }
  name                  = "${each.value.vnet_name}-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this[each.value.zone].name
  virtual_network_id    = each.value.vnet_id
}