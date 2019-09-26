#############################################################
##
## This app file contains the outputs of Compute / ELB installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/apps/wordpress/compute/elb
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

## Networking Outputs
output "elb_id" {
  description = "The ID of the Wordpress ELB"
  value       = join("", aws_elb.wordpress.*.id)
}
