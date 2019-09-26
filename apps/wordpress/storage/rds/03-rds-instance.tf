#############################################################
##
## This app file contains the Storage / RDS installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/apps/wordpress/storage/rds
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

## Random string for mysql
resource "random_string" "password" {
  count = "${var.enabled ? 1 : 0}"

  length  = 16
  special = true
}

## Put password into ssm
resource "aws_ssm_parameter" "vault_db_password" {
  count = "${var.enabled ? 1 : 0}"

  name  = "/${var.meta.project_slug}/${var.meta.environment}/database/password/master"
  type  = "SecureString"
  value = "${random_string.password[count.index].result}"

  tags = merge(var.meta.project_tags, {
    "Name" : "${var.meta.project_slug}-${var.meta.environment}-wordpress-database-password"
    "Environment" : var.meta.environment
    "Project" : var.meta.project_name
  })
}

resource "aws_db_instance" "wordpress" {
  count = "${var.enabled ? 1 : 0}"

  identifier = "${var.meta.project_slug}-${var.meta.environment}-wordpress-rds"

  allocated_storage = var.app_config.rds.allocated_storage
  storage_type      = var.app_config.rds.storage_type
  engine            = var.app_config.rds.engine
  engine_version    = var.app_config.rds.engine_version
  instance_class    = var.app_config.rds.instance_class

  multi_az = var.app_config.rds.multi_az

  name     = var.app_config.rds.database_name
  username = var.app_config.rds.database_username
  password = "${random_string.password[count.index].result}"

  db_subnet_group_name = aws_db_subnet_group.wordpress[count.index].id
  parameter_group_name = aws_db_parameter_group.wordpress[count.index].id

  tags = merge(var.meta.project_tags, {
    "Name" : "${var.meta.project_slug}-${var.meta.environment}-wordpress-rds"
    "Environment" : var.meta.environment
    "Project" : var.meta.project_name
  })
}
