variable "boundary_address" {
  type        = string
  description = "Boundary address"
}

variable "boundary_username" {
  type        = string
  description = "Boundary address"
}

variable "boundary_password" {
  type        = string
  description = "Boundary password"
  sensitive   = true
}

variable "boundary_scope_id" {
  type        = string
  description = "Boundary scope ID for setting up target to database"
}

variable "boundary_credentials_store_id" {
  type        = string
  description = "Boundary credentials store ID"
}

variable "consul_address" {
  type        = string
  description = "Consul address"
}

variable "consul_token" {
  type        = string
  description = "Consul token"
  sensitive   = true
}

variable "consul_datacenter" {
  type        = string
  description = "Consul datacenter"
  default     = null
}

variable "vault_address" {
  type        = string
  description = "Vault address"
}

variable "vault_token" {
  type        = string
  description = "Vault token"
  sensitive   = true
}

variable "vault_namespace" {
  type        = string
  description = "Vault namespace"
}

variable "postgres_db_version" {
  type        = string
  default     = "14.9"
  description = "PostgreSQL version"
}

variable "postgres_port" {
  type        = number
  description = "Database port"
  default     = 5432
}

variable "db_instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "Database instance class"
}

variable "org_name" {
  type        = string
  description = "Organization to search for VPC resources, including database subnet group"
}

variable "business_unit" {
  type        = string
  description = "Business unit"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "db_name" {
  type        = string
  description = "Database name to create in instance"
}

variable "use_vault_for_db_password" {
  type        = bool
  description = "Use Vault for database password"
  default     = true
}

variable "vault_kubernetes_auth_path" {
  type        = string
  description = "Vault Kubernetes auth path"
  default     = "kubernetes"
}

variable "vault_transit_secrets_engine_mount" {
  type        = string
  description = "Override default Vault transit secrets engine mount"
  default     = "transit"
}

variable "additional_service_account_names" {
  type        = list(string)
  description = "Additional service account names to allow access to database credentials"
  default     = []
}

variable "allow_major_version_upgrade" {
  type        = bool
  description = "Allow major version upgrades of database"
  default     = false
}

variable "initial_provision" {
  type        = bool
  description = "Initial provision"
  default     = true
}

locals {
  tags = {
    Environment   = var.environment
    Automation    = "terraform"
    Business_Unit = var.org_name
  }
  db_subnet_group_name = var.org_name
}
