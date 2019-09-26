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

resource "aws_autoscaling_attachment" "wordpress_elb_attachment" {
  count = "${var.enabled ? 1 : 0}"

  autoscaling_group_name = "${aws_autoscaling_group.wordpress_asg[count.index].id}"
  elb                    = var.app_config.elb.elb_id
}
