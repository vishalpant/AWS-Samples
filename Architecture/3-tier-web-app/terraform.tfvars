application_name                  = "test"
location                          = "West Europe"
sql_version                       = "12.0"
sql_public_network_access_enabled = false
vnet_address_space                = ["10.0.0.0/16"]
subnets = [
  {
    name             = "webapp"
    address_prefixes = ["10.0.0.0/23"]
    delegation = [{
      name               = "serverFarms"
      service_delegation = "Microsoft.Web/serverFarms"
    }]
  },
  {
    name             = "api"
    address_prefixes = ["10.0.2.0/23"]
    delegation = [{
      name               = "serverFarms"
      service_delegation = "Microsoft.Web/serverFarms"
    }]
  },
  {
    name             = "apim"
    address_prefixes = ["10.0.4.0/24"]
    delegation       = []
  },
  {
    name             = "db"
    address_prefixes = ["10.0.5.0/24"]
    delegation       = []
  }
]