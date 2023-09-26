terraform {
  required_providers {
    boundary = {
      source  = "hashicorp/boundary"
      version = "~> 1.1"
    }
  }
}

data "terraform_remote_state" "setup" {
  backend = "local"

  config = {
    path = "../setup/terraform.tfstate"
  }
}

provider "boundary" {
  addr                   = data.terraform_remote_state.setup.outputs.boundary.address
  auth_method_login_name = data.terraform_remote_state.setup.outputs.boundary.username
  auth_method_password   = data.terraform_remote_state.setup.outputs.boundary.password
}