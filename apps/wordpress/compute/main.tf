#############################################################
##
## This app file contains the Compute installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/apps/wordpress/compute
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

## EC2
module "ec2" {
  source = "./ec2"

  ## Networking Service
  networking_module = var.networking_module

  ## Application Config
  enabled    = var.enabled
  app_config = var.app_config

  ## Meta
  meta = var.meta
}
