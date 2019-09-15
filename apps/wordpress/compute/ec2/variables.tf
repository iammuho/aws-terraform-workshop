#############################################################
##
## This app file contains the variables of Compute / EC2 installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/apps/wordpress/compute/ec2
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

## Toggle
variable "enabled" {
  description = "If the application is enabled or not?"
  default     = false
}

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
