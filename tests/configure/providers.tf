terraform {
  required_providers {
    boundary = {
      source  = "hashicorp/boundary"
      version = "~> 1.1"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.20"
    }
  }
}

data "terraform_remote_state" "setup" {
  backend = "remote"

  config = {
    organization = var.tfc_organization
    workspaces = {
      name = "terraform-aws-postgres-test-setup"
    }
  }
}

provider "boundary" {
  addr                   = data.terraform_remote_state.setup.outputs.boundary.address
  auth_method_login_name = data.terraform_remote_state.setup.outputs.boundary.username
  auth_method_password   = data.terraform_remote_state.setup.outputs.boundary.password
}

provider "vault" {
  address   = data.terraform_remote_state.setup.outputs.vault.address
  token     = data.terraform_remote_state.setup.outputs.vault.token
  namespace = data.terraform_remote_state.setup.outputs.vault.namespace
}