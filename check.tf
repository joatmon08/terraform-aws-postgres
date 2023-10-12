data "aws_db_instance" "check" {
  count                  = var.initial_provision ? 0 : 1
  db_instance_identifier = "${var.business_unit}-${var.db_name}"
}