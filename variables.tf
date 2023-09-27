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
  default     = "13.11"
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

variable "business_unit" {
  type        = string
  description = "Business unit. Also used as database subnet group"
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

locals {
  tags = {
    Environment   = var.environment
    Automation    = "terraform"
    Business_Unit = var.business_unit
  }
  db_subnet_group_name = var.business_unit
}