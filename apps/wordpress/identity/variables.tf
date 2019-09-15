#############################################################
##
## This app file contains the variables of Identity installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/apps/wordpress/identity/
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

## Meta
variable "meta" {
  description = "Application meta, which contains tags, environment or application name"
  default     = {}
}

## Apps
variable "app_config" {
  description = "App Config aims to hold data related with will be provisioned apps"
  default     = {}
}
