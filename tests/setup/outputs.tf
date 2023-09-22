resource "local_file" "variables" {
  content  = <<EOT
boundary_address = "${hcp_boundary_cluster.main.cluster_url}"
boundary_username = "${hcp_boundary_cluster.main.username}"
boundary_password = "${hcp_boundary_cluster.main.password}"
boundary_scope_id = "${boundary_scope.test.id}"
consul_address    = "${hcp_consul_cluster.main.consul_public_endpoint_url}"
consul_datacenter = "${hcp_consul_cluster.main.datacenter}"
consul_token      = "${hcp_consul_cluster_root_token.token.secret_id}"
vault_address     = "${hcp_vault_cluster.main.vault_public_endpoint_url}"
vault_token       = "${hcp_vault_cluster_admin_token.cluster.token}"
vault_namespace   = "${hcp_vault_cluster.main.namespace}"
EOT
  filename = "../secrets.auto.tfvars"
}
