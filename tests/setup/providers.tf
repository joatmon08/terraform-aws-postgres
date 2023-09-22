terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.13"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }

    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.45"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = var.tags
  }
}

provider "hcp" {
  project_id = var.hcp_project_id
}

provider "boundary" {
  addr                   = hcp_boundary_cluster.main.cluster_url
  auth_method_login_name = hcp_boundary_cluster.main.username
  auth_method_password   = hcp_boundary_cluster.main.password
}