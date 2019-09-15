#############################################################
##
## This app file contains the Apps installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/apps
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

## Wordpress
module "wordpress" {
  source = "./wordpress"

  ## Networking Service
  networking_module = var.networking_module

  ## Application Config
  app_config = var.apps.wordpress

  ## Meta
  meta = var.meta
}
