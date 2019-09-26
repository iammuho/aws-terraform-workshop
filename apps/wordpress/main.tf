#############################################################
##
## This app file contains the Wordpress installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/apps/wordpress
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

## Networking
module "networking" {
  source = "./networking"

  ## Networking Service
  networking_module = var.networking_module

  ## Application Config
  app_config = var.app_config

  ## Meta
  meta = var.meta
}

## Identity
module "identity" {
  source = "./identity"

  ## Application Config
  app_config = var.app_config

  ## Meta
  meta = var.meta
}

## Storage
module "storage" {
  source = "./storage"

  ## Networking Service
  networking_module = var.networking_module

  ## Application Config
  enabled = var.app_config.enabled

  app_config = merge(var.app_config, {
    "identity" : module.identity
    "networking" : module.networking
  })

  ## Meta
  meta = var.meta
}


## Compute
module "compute" {
  source = "./compute"

  ## Networking Service
  networking_module = var.networking_module

  ## Application Config
  enabled = var.app_config.enabled

  app_config = merge(var.app_config, {
    "identity" : module.identity
    "networking" : module.networking
  })

  ## Meta
  meta = var.meta
}
