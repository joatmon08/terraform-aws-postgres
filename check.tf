data "aws_db_instance" "check" {
  db_instance_identifier = "${var.business_unit}-${var.db_name}"
}