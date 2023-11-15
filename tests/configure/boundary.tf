resource "boundary_scope" "org" {
  scope_id                 = "global"
  name                     = data.terraform_remote_state.setup.outputs.name
  description              = "HashiCups scope"
  auto_create_default_role = true
  auto_create_admin_role   = true
}

// create a project for test
resource "boundary_scope" "test" {
  name                     = "test"
  description              = "test project"
  scope_id                 = boundary_scope.org.id
  auto_create_admin_role   = true
  auto_create_default_role = true
}

resource "boundary_credential_store_vault" "test" {
  name        = "vault"
  description = "Vault credentials store"
  address     = data.terraform_remote_state.setup.outputs.vault.address
  token       = vault_token.boundary_controller.client_token
  namespace   = data.terraform_remote_state.setup.outputs.vault.namespace
  scope_id    = boundary_scope.test.id
}