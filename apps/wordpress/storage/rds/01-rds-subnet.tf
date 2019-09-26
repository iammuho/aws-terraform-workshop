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

resource "aws_db_subnet_group" "wordpress" {
  count = "${var.enabled ? 1 : 0}"

  name       = "${var.meta.project_slug}-${var.meta.environment}-wordpress-rds-subnet"
  subnet_ids = var.networking_module.private_subnets

  tags = merge(var.meta.project_tags, {
    "Name" : "${var.meta.project_slug}-${var.meta.environment}-wordpress-rds-subnet"
    "Environment" : var.meta.environment
    "Project" : var.meta.project_name
  })
}
