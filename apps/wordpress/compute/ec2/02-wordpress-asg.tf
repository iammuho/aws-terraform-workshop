#############################################################
##
## This app file contains the Compute / EC2 installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/apps/wordpress/compute/ec2
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

resource "aws_autoscaling_group" "wordpress_asg" {
  count = "${var.enabled ? 1 : 0}"

  name = "${var.meta.project_slug}-${var.meta.environment}-wordpress-asg"

  vpc_zone_identifier = var.networking_module.private_subnets

  max_size                  = var.app_config.autoscaling.maximum
  min_size                  = var.app_config.autoscaling.minimum
  desired_capacity          = var.app_config.autoscaling.desired
  health_check_grace_period = "600"
  health_check_type         = "EC2"

  mixed_instances_policy {

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.wordpress_launch_template[count.index].id
        version            = aws_launch_template.wordpress_launch_template[count.index].latest_version
      }
    }
  }

  tag {
    key                 = "Name"
    value               = "${var.meta.project_slug}-${var.meta.environment}-wordpress"
    propagate_at_launch = true
  }

  tag {
    key                 = "Application"
    value               = "wordpress"
    propagate_at_launch = true
  }

  tag {
    key                 = "Description"
    value               = "Wordpress Application Instances"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.meta.environment
    propagate_at_launch = true
  }
}
