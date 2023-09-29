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

data "vault_policy_document" "transit" {
  rule {
    path         = "${var.vault_transit_secrets_engine_mount}/encrypt/${vault_transit_secret_backend_key.transit.name}"
    capabilities = ["update"]
    description  = "use transit secrets engine to encrypt data"
  }
  rule {
    path         = "${var.vault_transit_secrets_engine_mount}/decrypt/${vault_transit_secret_backend_key.transit.name}"
    capabilities = ["update"]
    description  = "use transit secrets engine to decrypt data"
  }
}

resource "vault_policy" "transit" {
  name   = "${var.business_unit}-transit"
  policy = data.vault_policy_document.transit.hcl
}

resource "vault_kubernetes_auth_backend_role" "db" {
  backend                          = var.vault_kubernetes_auth_path
  role_name                        = vault_database_secret_backend_role.db.name
  bound_service_account_names      = concat([var.business_unit], var.additional_service_account_names)
  bound_service_account_namespaces = [var.business_unit]
  token_ttl                        = 3600
  token_policies                   = [vault_policy.db.name, vault_policy.transit.name]
}