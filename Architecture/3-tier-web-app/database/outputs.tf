output "sql_server_admin_user" {
  sensitive = true
  value     = local.sql_server_admin_user
}

output "sql_server_admin_user_password" {
  sensitive = true
  value     = random_password.this.result
}