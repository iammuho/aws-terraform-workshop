#############################################################
##
## This app file contains the outputs of Identity / IAM installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/apps/wordpress/identity/iam/
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

output "instance_profile_arn" {
  description = "The ARN of the Wordpress IAM Instance Profile"
  value       = join("", aws_iam_instance_profile.wordpress_instance.*.arn)
}
