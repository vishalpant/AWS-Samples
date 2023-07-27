output "private_dns_zone_ids" {
  value = {
    for zone in azurerm_private_dns_zone.this : zone.name => zone.id
  }
}