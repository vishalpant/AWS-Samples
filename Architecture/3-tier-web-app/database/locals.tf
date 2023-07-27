locals {
  managed_identity_name   = "${var.sql_server_name}-identity"
  sql_server_admin_user   = "${var.sql_server_name}-administrator"
  app_subnet_traffic_rule = "${var.sql_server_name}-app-subnet-allow"
}