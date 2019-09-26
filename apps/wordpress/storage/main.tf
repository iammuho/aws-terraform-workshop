#############################################################
##
## This app file contains the Storage installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/apps/wordpress/storage
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

## RDS
module "rds" {
  source = "./rds"

  ## Networking Service
  networking_module = var.networking_module

  ## Application Config
  enabled    = var.enabled
  app_config = var.app_config

  ## Meta
  meta = var.meta
}
