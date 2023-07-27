output "sql_server_admin_user" {
  sensitive = true
  value     = module.database.sql_server_admin_user
}

output "sql_server_admin_user_password" {
  sensitive = true
  value     = module.database.sql_server_admin_user_password
}