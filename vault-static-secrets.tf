resource "vault_mount" "static" {
  count       = var.use_vault_for_db_password ? 1 : 0
  path        = "${var.business_unit}/static"
  type        = "kv"
  options     = { version = "2" }
  description = "For static secrets related to ${var.business_unit}"
}

locals {
  database_secret_name = var.db_name
}

resource "vault_kv_secret_v2" "postgres" {
  count               = var.use_vault_for_db_password ? 1 : 0
  mount               = vault_mount.static.0.path
  name                = local.database_secret_name
  delete_all_versions = true

  data_json = <<EOT
{
  "username": "${aws_db_instance.database.username}",
  "password": "${aws_db_instance.database.password}"
}
EOT
}

data "vault_kv_secret_v2" "postgres" {
  count = var.use_vault_for_db_password ? 1 : 0
  mount = vault_kv_secret_v2.postgres.0.mount
  name  = vault_kv_secret_v2.postgres.0.name
}
