resource "local_file" "variables" {
  content  = <<EOT
boundary_scope_id = "${boundary_scope.test.id}"
boundary_credentials_store_id = "${boundary_credential_store_vault.test.id}"
EOT
  filename = "../boundary.auto.tfvars"
}
