terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    boundary = {
      source  = "hashicorp/boundary"
      version = ">= 1.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.20"
    }

    consul = {
      source  = "hashicorp/consul"
      version = ">= 2.18"
    }
  }
}

## Possible bug with Boundary provider, doesn't pick up BOUNDARY_ADDR
provider "boundary" {
  addr                   = var.boundary_address
  auth_method_login_name = var.boundary_username
  auth_method_password   = var.boundary_password
}

provider "consul" {
  address    = var.consul_address
  token      = var.consul_token
  datacenter = var.consul_datacenter
}

provider "vault" {
  address   = var.vault_address
  token     = var.vault_token
  namespace = var.vault_namespace
}