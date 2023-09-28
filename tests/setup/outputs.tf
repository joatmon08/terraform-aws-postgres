resource "local_file" "variables" {
  content  = <<EOT
name              = "${var.name}"
boundary_address  = "${hcp_boundary_cluster.main.cluster_url}"
boundary_username = "${hcp_boundary_cluster.main.username}"
boundary_password = "${hcp_boundary_cluster.main.password}"
consul_address    = "${hcp_consul_cluster.main.consul_public_endpoint_url}"
consul_datacenter = "${hcp_consul_cluster.main.datacenter}"
consul_token      = "${hcp_consul_cluster_root_token.token.secret_id}"
vault_address     = "${hcp_vault_cluster.main.vault_public_endpoint_url}"
vault_token       = "${hcp_vault_cluster_admin_token.cluster.token}"
vault_namespace   = "${hcp_vault_cluster.main.namespace}"
EOT
  filename = "../secrets.auto.tfvars"
}

output "boundary" {
  value = {
    address  = hcp_boundary_cluster.main.cluster_url
    username = hcp_boundary_cluster.main.username
    password = hcp_boundary_cluster.main.password
  }
  sensitive = true
}

output "vault" {
  value = {
    address   = hcp_vault_cluster.main.vault_public_endpoint_url
    token     = hcp_vault_cluster_admin_token.cluster.token
    namespace = hcp_vault_cluster.main.namespace
  }
  sensitive = true
}

output "name" {
  value = var.name
}