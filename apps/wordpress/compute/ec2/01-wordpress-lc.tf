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

## Rendered Templates
data "template_file" "wordpress" {
  count = "${var.enabled ? 1 : 0}"

  template = file("${path.module}/files/scripts/install-wordpress.sh")
}

## Cloud init configs
data "template_cloudinit_config" "wordpress" {
  count = "${var.enabled ? 1 : 0}"

  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    filename     = "userdata.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.wordpress[count.index].rendered
  }
}

resource "aws_launch_template" "wordpress_launch_template" {
  count = "${var.enabled ? 1 : 0}"

  name                   = "${var.meta.project_slug}-${var.meta.environment}-wordpress-lc"
  image_id               = var.app_config.ec2.ami_id
  instance_type          = var.app_config.ec2.instance_size
  key_name               = var.app_config.ec2.key_pair
  vpc_security_group_ids = [var.app_config.networking.instance_sg_id]

  user_data = data.template_cloudinit_config.wordpress[count.index].rendered

  iam_instance_profile {
    arn = var.app_config.identity.instance_profile_arn
  }
}
