#############################################################
##
## This app file contains the Variables of Apps installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/apps
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

## Networking Service
variable "networking_module" {
  description = "Networking service aims to hold data related with networking services"
  default     = {}
}

## Apps
variable "app_config" {
  description = "App Config aims to hold data related with will be provisioned apps"
  default     = {}
}
