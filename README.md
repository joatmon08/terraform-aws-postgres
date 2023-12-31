# terraform-aws-postgres

Sample module creating RDS PostgreSQL database, Boundary targets, and Consul registration.
It is intended to run with an operator, which means defining provider variables inline.

Full demo at: https://github.com/joatmon08/hashicorp-stack-demoapp

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |
| <a name="requirement_boundary"></a> [boundary](#requirement\_boundary) | >= 1.0 |
| <a name="requirement_consul"></a> [consul](#requirement\_consul) | >= 2.18 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >= 3.20 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.17.0 |
| <a name="provider_boundary"></a> [boundary](#provider\_boundary) | 1.1.9 |
| <a name="provider_consul"></a> [consul](#provider\_consul) | 2.18.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 3.20.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [boundary_credential_library_vault.database_admin](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/credential_library_vault) | resource |
| [boundary_credential_library_vault.database_app](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/credential_library_vault) | resource |
| [boundary_host_catalog_static.database](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/host_catalog_static) | resource |
| [boundary_host_set_static.database](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/host_set_static) | resource |
| [boundary_host_static.database](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/host_static) | resource |
| [boundary_target.database_admin](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/target) | resource |
| [boundary_target.database_app](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/target) | resource |
| [consul_config_entry.service_defaults](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/config_entry) | resource |
| [consul_node.database](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/node) | resource |
| [consul_service.database](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/service) | resource |
| [random_password.database](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_pet.database](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [vault_database_secret_backend_connection.db](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/database_secret_backend_connection) | resource |
| [vault_database_secret_backend_role.db](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/database_secret_backend_role) | resource |
| [vault_kubernetes_auth_backend_role.db](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kubernetes_auth_backend_role) | resource |
| [vault_kv_secret_v2.postgres](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kv_secret_v2) | resource |
| [vault_mount.db](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_mount.static](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_policy.db](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.transit](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_transit_secret_backend_key.transit](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/transit_secret_backend_key) | resource |
| [aws_security_group.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [consul_service_health.database](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/data-sources/service_health) | data source |
| [vault_kv_secret_v2.postgres](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/kv_secret_v2) | data source |
| [vault_policy_document.db](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document) | data source |
| [vault_policy_document.transit](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_service_account_names"></a> [additional\_service\_account\_names](#input\_additional\_service\_account\_names) | Additional service account names to allow access to database credentials | `list(string)` | `[]` | no |
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | Allow major version upgrades of database | `bool` | `true` | no |
| <a name="input_boundary_address"></a> [boundary\_address](#input\_boundary\_address) | Boundary address | `string` | n/a | yes |
| <a name="input_boundary_credentials_store_id"></a> [boundary\_credentials\_store\_id](#input\_boundary\_credentials\_store\_id) | Boundary credentials store ID | `string` | n/a | yes |
| <a name="input_boundary_password"></a> [boundary\_password](#input\_boundary\_password) | Boundary password | `string` | n/a | yes |
| <a name="input_boundary_scope_id"></a> [boundary\_scope\_id](#input\_boundary\_scope\_id) | Boundary scope ID for setting up target to database | `string` | n/a | yes |
| <a name="input_boundary_username"></a> [boundary\_username](#input\_boundary\_username) | Boundary address | `string` | n/a | yes |
| <a name="input_business_unit"></a> [business\_unit](#input\_business\_unit) | Business unit | `string` | n/a | yes |
| <a name="input_consul_address"></a> [consul\_address](#input\_consul\_address) | Consul address | `string` | n/a | yes |
| <a name="input_consul_datacenter"></a> [consul\_datacenter](#input\_consul\_datacenter) | Consul datacenter | `string` | `null` | no |
| <a name="input_consul_token"></a> [consul\_token](#input\_consul\_token) | Consul token | `string` | n/a | yes |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | Database instance class | `string` | `"db.t3.micro"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database name to create in instance | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `string` | n/a | yes |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Organization to search for VPC resources, including database subnet group | `string` | n/a | yes |
| <a name="input_postgres_db_version"></a> [postgres\_db\_version](#input\_postgres\_db\_version) | PostgreSQL version | `string` | `"14.9"` | no |
| <a name="input_postgres_port"></a> [postgres\_port](#input\_postgres\_port) | Database port | `number` | `5432` | no |
| <a name="input_use_vault_for_db_password"></a> [use\_vault\_for\_db\_password](#input\_use\_vault\_for\_db\_password) | Use Vault for database password | `bool` | `true` | no |
| <a name="input_vault_address"></a> [vault\_address](#input\_vault\_address) | Vault address | `string` | n/a | yes |
| <a name="input_vault_kubernetes_auth_path"></a> [vault\_kubernetes\_auth\_path](#input\_vault\_kubernetes\_auth\_path) | Vault Kubernetes auth path | `string` | `"kubernetes"` | no |
| <a name="input_vault_namespace"></a> [vault\_namespace](#input\_vault\_namespace) | Vault namespace | `string` | n/a | yes |
| <a name="input_vault_token"></a> [vault\_token](#input\_vault\_token) | Vault token | `string` | n/a | yes |
| <a name="input_vault_transit_secrets_engine_mount"></a> [vault\_transit\_secrets\_engine\_mount](#input\_vault\_transit\_secrets\_engine\_mount) | Override default Vault transit secrets engine mount | `string` | `"transit"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_boundary_target_postgres"></a> [boundary\_target\_postgres](#output\_boundary\_target\_postgres) | n/a |
| <a name="output_boundary_target_postgres_app"></a> [boundary\_target\_postgres\_app](#output\_boundary\_target\_postgres\_app) | n/a |
| <a name="output_database_secret_name"></a> [database\_secret\_name](#output\_database\_secret\_name) | Name of secret with database admin credentials |
| <a name="output_database_static_path"></a> [database\_static\_path](#output\_database\_static\_path) | Path to static secrets related to database service |
| <a name="output_product_database_address"></a> [product\_database\_address](#output\_product\_database\_address) | n/a |
| <a name="output_vault_paths"></a> [vault\_paths](#output\_vault\_paths) | n/a |
