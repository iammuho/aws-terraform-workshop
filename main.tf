#############################################################
##
## This app file contains the Main installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

provider "aws" {
  region = "eu-central-1"
}

## Networking
module "networking" {
  source = "./modules/networking/"

  ## Networking Service
  networking_service = var.networking_service

  ## Meta
  meta = var.meta
}
