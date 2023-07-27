locals {
  dns_zone_vnet_link = flatten([
    for zone in var.private_dns_zones : [
      for vnet in zone.vnets :
      {
        vnet_name = vnet.name
        vnet_id   = vnet.id
        zone      = zone.private_dns_zone
      }
    ]
  ])
}