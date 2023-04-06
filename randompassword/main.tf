resource "random_password" "password" {
  length           = 9
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
resource "aws_db_instance" "example" {
  instance_class      = var.dbinstanceingo.instancetype
  allocated_storage   = var.dbinstanceingo.storage
  engine              = var.dbinstanceingo.engine
  username            = var.dbinstanceingo.username
  password            = random_password.password.result
  skip_final_snapshot = true
}