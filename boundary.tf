resource "boundary_host_catalog_static" "database" {
  name        = "${var.business_unit}-database"
  description = "${var.business_unit} database"
  scope_id    = var.boundary_scope_id
}

resource "boundary_host_static" "database" {
  type            = "static"
  name            = "${var.business_unit}-database"
  description     = "${var.business_unit} database"
  address         = aws_db_instance.database.address
  host_catalog_id = boundary_host_catalog_static.database.id
}

resource "boundary_host_set_static" "database" {
  type            = "static"
  name            = "${var.business_unit}-database"
  description     = "Host set for ${var.business_unit} database"
  host_catalog_id = boundary_host_catalog_static.database.id
  host_ids        = [boundary_host_static.database.id]
}

resource "boundary_target" "database_admin" {
  type                     = "tcp"
  name                     = "database-admin"
  description              = "ADMIN ${var.business_unit} Database Postgres Target"
  scope_id                 = var.boundary_scope_id
  ingress_worker_filter    = "\"rds\" in \"/tags/type\""
  egress_worker_filter     = "\"${var.org_name}\" in \"/tags/type\""
  session_connection_limit = 2
  default_port             = 5432
  host_source_ids = [
    boundary_host_set_static.database.id
  ]
  brokered_credential_source_ids = [
    boundary_credential_library_vault.database_admin.id
  ]
}

resource "boundary_target" "database_app" {
  type                     = "tcp"
  name                     = "database-app"
  description              = "APP ${var.business_unit} Database Postgres Target"
  scope_id                 = var.boundary_scope_id
  ingress_worker_filter    = "\"rds\" in \"/tags/type\""
  egress_worker_filter     = "\"${var.org_name}\" in \"/tags/type\""
  session_connection_limit = 2
  default_port             = 5432
  host_source_ids = [
    boundary_host_set_static.database.id
  ]
  brokered_credential_source_ids = [
    boundary_credential_library_vault.database_admin.id
  ]
}

resource "boundary_credential_library_vault" "database_admin" {
  name                = "database-admin-${var.business_unit}"
  description         = "Admin credential library for ${var.business_unit} databases"
  credential_store_id = var.boundary_credentials_store_id
  path                = "${vault_kv_secret_v2.postgres.0.mount}/data/${vault_kv_secret_v2.postgres.0.name}"
  http_method         = "GET"
  credential_type     = "username_password"
}

resource "boundary_credential_library_vault" "database_app" {
  name                = "database-app-${var.business_unit}"
  description         = "App credential library for ${var.business_unit} databases"
  credential_store_id = var.boundary_credentials_store_id
  path                = "${vault_mount.db.path}/creds/${vault_database_secret_backend_role.db.name}"
  http_method         = "GET"
  credential_type     = "username_password"
}