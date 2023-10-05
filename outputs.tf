output "product_database_address" {
  value = aws_db_instance.database.address
}

output "database_static_path" {
  value       = var.use_vault_for_db_password ? vault_mount.static.0.path : aws_db_instance.database.master_user_secret.0.secret_arn
  description = "Path to static secrets related to database service"
}

output "database_secret_name" {
  value       = local.database_secret_name
  description = "Name of secret with database admin credentials"
}

output "boundary_target_postgres" {
  value = boundary_target.database_admin.id
}

output "boundary_target_postgres_app" {
  value = boundary_target.database_app.id
}

output "vault_paths" {
  value = {
    db      = "${vault_mount.db.path}/creds/${vault_database_secret_backend_role.db.name}"
    encrypt = "${var.vault_transit_secrets_engine_mount}/encrypt/${vault_transit_secret_backend_key.transit.name}"
    decrypt = "${var.vault_transit_secrets_engine_mount}/encrypt/${vault_transit_secret_backend_key.transit.name}"
  }
}