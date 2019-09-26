#############################################################
##
## This app file contains the Compute / ELB installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/apps/wordpress/compute/elb
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

## External Load Balancer for API Controller Manager
resource "aws_elb" "wordpress" {
  count = "${var.enabled ? 1 : 0}"

  name = "${var.meta.project_slug}-${var.meta.environment}-wordpress-elb"

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  security_groups = [var.app_config.networking.elb_sg_id]
  subnets         = var.networking_module.public_subnets

  health_check {
    target              = "TCP:80"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
  }

  idle_timeout = 300

  tags = merge(var.meta.project_tags, {
    "Name" : "${var.meta.project_slug}-${var.meta.environment}-wordpress-elb"
    "Environment" : var.meta.environment
    "Project" : var.meta.project_name
  })
}
