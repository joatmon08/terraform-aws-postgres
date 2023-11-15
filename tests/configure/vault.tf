resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

resource "vault_policy" "boundary_controller" {
  name   = "boundary-controller"
  policy = <<EOT
path "auth/token/lookup-self" {
  capabilities = ["read"]
}

path "auth/token/renew-self" {
  capabilities = ["update"]
}

path "auth/token/revoke-self" {
  capabilities = ["update"]
}

path "sys/leases/renew" {
  capabilities = ["update"]
}

path "sys/leases/revoke" {
  capabilities = ["update"]
}

path "sys/capabilities-self" {
  capabilities = ["update"]
}
EOT
}

resource "vault_token" "boundary_controller" {
  policies          = [vault_policy.boundary_controller.name]
  no_default_policy = true
  no_parent         = true
  ttl               = "14d"
  explicit_max_ttl  = "21d"
  period            = "14d"
  renewable         = true
  num_uses          = 0
}

resource "vault_mount" "transit" {
  path                      = "transit"
  type                      = "transit"
  description               = "Enable transit secrets backend"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}