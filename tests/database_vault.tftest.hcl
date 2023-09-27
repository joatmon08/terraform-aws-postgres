variables {
  business_unit = "modules"
  environment   = "dev"
  db_name       = "test"
}

provider "aws" {
  region = "us-west-2"
  default_tags {
    tags = {
      Business_Unit = "modules"
      Environment   = "dev"
      Automation    = "terraform"
      Repo          = "terraform-aws-postgres"
    }
  }
}

run "setup" {
  command = apply
}

run "database" {
  command = plan

  assert {
    condition     = !aws_db_instance.database.publicly_accessible
    error_message = "Database in module should not be publicly accessible"
  }

  assert {
    condition     = aws_db_instance.database.storage_encrypted
    error_message = "Database in module should be encrypted"
  }

  assert {
    condition     = aws_db_instance.database.manage_master_user_password == null
    error_message = "Database password should be stored in Vault and not managed by AWS"
  }

  assert {
    condition     = aws_db_instance.database.status == "available"
    error_message = "Database in module should be available"
  }

  assert {
    condition     = data.vault_kv_secret_v2.postgres.0.data["username"] != null
    error_message = "Database in module should have admin credentials in Vault"
  }

  assert {
    condition     = data.vault_generic_secret.database_credentials.data["username"] != data.vault_kv_secret_v2.postgres.0.data["username"]
    error_message = "Database in module should have dynamic database credentials from Vault"
  }

  assert {
    condition     = length(data.consul_service_health.database.results) > 0
    error_message = "Database service not registered in Consul"
  }
}

## Boundary has no data sources
