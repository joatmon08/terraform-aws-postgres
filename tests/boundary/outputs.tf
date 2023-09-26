resource "local_file" "variables" {
  content  = <<EOT
boundary_scope_id = "${boundary_scope.test.id}"
EOT
  filename = "../boundary.auto.tfvars"
}
