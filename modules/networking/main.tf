#############################################################
##
## This app file contains the variables of Networking installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/modules/networking
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_eip" "nat" {
  count = "${var.networking_service.enabled && var.networking_service.nat.enabled ? length(var.networking_service.private_subnet.cidr) : 0}"
  vpc   = true
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  create_vpc = var.networking_service.enabled

  name = "${var.meta.project_slug}-${var.meta.environment}-vpc"
  cidr = var.networking_service.vpc.cidr

  azs             = data.aws_availability_zones.available.names
  public_subnets  = var.networking_service.public_subnet.cidr
  private_subnets = var.networking_service.private_subnet.cidr

  enable_nat_gateway  = var.networking_service.nat.enabled
  single_nat_gateway  = var.networking_service.nat.single_nat_gateway
  reuse_nat_ips       = var.networking_service.nat.reuse_nat_ips
  external_nat_ip_ids = "${aws_eip.nat.*.id}"

  enable_dns_hostnames = var.networking_service.vpc.enable_dns_hostnames
  enable_dns_support   = var.networking_service.vpc.enable_dns_support

  tags = merge(var.meta.project_tags, {
    Environment = var.meta.environment
    Terraform   = "Yes"
  })
}
