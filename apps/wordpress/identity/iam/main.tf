#############################################################
##
## This app file contains the Identity / IAM installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/apps/wordpress/identity/iam/
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

resource "aws_iam_role" "wordpress_instance" {
  count = "${var.app_config.enabled ? 1 : 0}"

  name = "${var.meta.project_slug}-${var.meta.environment}-wordpress-iam-role"

  assume_role_policy = file("${path.module}/files/wordpress_instance_assume_role_policy.json")
}

resource "aws_iam_instance_profile" "wordpress_instance" {
  count = "${var.app_config.enabled ? 1 : 0}"

  name = "${var.meta.project_slug}-${var.meta.environment}-wordpress-instance-profile"
  role = aws_iam_role.wordpress_instance[count.index].name
}
