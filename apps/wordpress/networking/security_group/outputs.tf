#############################################################
##
## This app file contains the outputs of Security Group installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/apps/wordpress/networking/security_group
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

## Networking Outputs
output "elb_sg_id" {
  description = "The ID of the Wordpress ELB Security Group"
  value       = join("", aws_security_group.wordpress_elb.*.id)
}

output "instance_sg_id" {
  description = "The ID of the Wordpress Instance Security Group"
  value       = join("", aws_security_group.wordpress_instance.*.id)
}
