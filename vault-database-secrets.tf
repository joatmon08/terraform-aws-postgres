resource "vault_mount" "db" {
  path = "${var.business_unit}/database"
  type = "database"
}

resource "vault_database_secret_backend_connection" "db" {
  backend       = vault_mount.db.path
  name          = var.db_name
  allowed_roles = ["*"]

  postgresql {
    connection_url = "postgresql://{{username}}:{{password}}@${aws_db_instance.database.address}:${var.postgres_port}/${var.db_name}?sslmode=disable"
    username       = aws_db_instance.database.username
    password       = aws_db_instance.database.password
  }
}

resource "vault_database_secret_backend_role" "db" {
  backend               = vault_mount.db.path
  name                  = var.db_name
  db_name               = vault_database_secret_backend_connection.db.name
  creation_statements   = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";"]
  revocation_statements = ["ALTER ROLE \"{{name}}\" NOLOGIN;"]
  default_ttl           = 3600
  max_ttl               = 3600
}

data "vault_policy_document" "db" {
  rule {
    path         = "${vault_mount.db.path}/creds/${vault_database_secret_backend_role.db.name}"
    capabilities = ["read"]
    description  = "get database credentials for ${vault_database_secret_backend_role.db.name}"
  }
}

resource "vault_policy" "db" {
  name   = vault_database_secret_backend_role.db.name
  policy = data.vault_policy_document.db.hcl
}

resource "vault_kubernetes_auth_backend_role" "db" {
  backend                          = var.vault_kubernetes_auth_path
  role_name                        = vault_database_secret_backend_role.db.name
  bound_service_account_names      = [var.business_unit]
  bound_service_account_namespaces = [var.business_unit]
  token_ttl                        = 3600
  token_policies                   = [vault_policy.db.name]
}

data "vault_generic_secret" "database_credentials" {
  path = "${vault_mount.db.path}/creds/${vault_database_secret_backend_role.db.name}"
}