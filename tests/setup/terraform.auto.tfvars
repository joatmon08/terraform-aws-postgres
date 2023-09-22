region     = "us-west-2"
hcp_region = "us-west-2"

name                       = "modules"
hcp_consul_public_endpoint = true
hcp_vault_public_endpoint  = true

tags = {
  Environment   = "dev"
  Automation    = "terraform"
  Business_Unit = "modules"
  Repo          = "terraform-aws-postgres"
}
