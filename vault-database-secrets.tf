resource "vault_mount" "db" {
  path = "${var.business_unit}/database"
  type = "database"
}

resource "vault_database_secret_backend_connection" "db" {
  backend       = vault_mount.db.path
  name          = var.db_name
  allowed_roles = [var.db_name]

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
  creation_statements   = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; GRANT SELECT ON ${var.db_name} TO \"{{name}}\"; GRANT INSERT ON ${var.db_name} TO \"{{name}}\";"]
  revocation_statements = ["ALTER ROLE \"{{name}}\" NOLOGIN;"]
  default_ttl           = 3600
  max_ttl               = 3600
}