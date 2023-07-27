resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "this" {
  for_each             = { for subnet in var.subnets : subnet.name => subnet }
  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = each.value.address_prefixes
  dynamic "delegation" {
    for_each = { for delegation in each.value.delegation : delegation.name => delegation}
    content {
      name = delegation.value.name
      service_delegation {
        name = delegation.value.service_delegation
      }
    }
  }
}