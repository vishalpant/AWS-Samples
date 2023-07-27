output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  value = {
    for subnet in azurerm_subnet.this : subnet.name => subnet.id
  }
}