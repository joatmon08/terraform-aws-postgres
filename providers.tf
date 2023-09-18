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
  addr                            = var.boundary_address
  password_auth_method_login_name = var.boundary_username
  password_auth_method_password   = var.boundary_password
}

provider "consul" {
  address    = var.consul_address
  datacenter = var.consul_datacenter
}