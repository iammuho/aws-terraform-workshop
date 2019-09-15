#############################################################
##
## This app file contains the Networking installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/apps/wordpress/networking/
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

## Security Group
module "security_group" {
  source = "./security_group"

  ## Networking Service
  networking_module = var.networking_module

  ## Application Config
  app_config = var.app_config

  ## Meta
  meta = var.meta
}
