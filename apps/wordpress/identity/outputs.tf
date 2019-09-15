#############################################################
##
## This app file contains the outputs of Identity installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/apps/wordpress/identity/
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

output "instance_profile_arn" {
  description = "The ARN of the Wordpress IAM Instance Profile"
  value       = module.iam.instance_profile_arn
}
