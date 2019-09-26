#############################################################
##
## This app file contains the Security Group installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop/apps/wordpress/security_group
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

resource "aws_security_group" "wordpress_elb" {
  count = "${var.app_config.enabled ? 1 : 0}"

  name        = "${var.meta.project_slug}-${var.meta.environment}-wordpress-elb-sg"
  description = "Allow http/s traffic from the internet and forward to wordpress instance"
  vpc_id      = "${var.networking_module.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] ## whole internet
  }

  tags = merge(var.meta.project_tags, {
    "Name" : "${var.meta.project_slug}-${var.meta.environment}-wordpress-elb-sg"
    "Environment" : var.meta.environment
    "Project" : var.meta.project_name
  })
}

resource "aws_security_group" "wordpress_instance" {
  count = "${var.app_config.enabled ? 1 : 0}"

  name        = "${var.meta.project_slug}-${var.meta.environment}-wordpress-instance-sg"
  description = "Allow http traffic from load balancer"
  vpc_id      = "${var.networking_module.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.meta.project_tags, {
    "Name" : "${var.meta.project_slug}-${var.meta.environment}-wordpress-instance-sg"
    "Environment" : var.meta.environment
    "Project" : var.meta.project_name
  })
}


resource "aws_security_group" "wordpress_database" {
  count = "${var.app_config.enabled ? 1 : 0}"

  name        = "${var.meta.project_slug}-${var.meta.environment}-wordpress-database-sg"
  description = "Allow http traffic from instance"
  vpc_id      = "${var.networking_module.vpc_id}"

  tags = merge(var.meta.project_tags, {
    "Name" : "${var.meta.project_slug}-${var.meta.environment}-wordpress-database-sg"
    "Environment" : var.meta.environment
    "Project" : var.meta.project_name
  })
}

resource "aws_security_group_rule" "wordpress-instance-from-load-balancer" {
  count = "${var.app_config.enabled ? 1 : 0}"

  description = "Accept traffic from load balancer security group"

  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  security_group_id        = aws_security_group.wordpress_instance[count.index].id
  source_security_group_id = aws_security_group.wordpress_elb[count.index].id
}

resource "aws_security_group_rule" "wordpress-load-balancer-to-instance" {
  count = "${var.app_config.enabled ? 1 : 0}"

  description = "Send traffic from load balancer to instance security group"

  type      = "egress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  security_group_id        = aws_security_group.wordpress_elb[count.index].id
  source_security_group_id = aws_security_group.wordpress_instance[count.index].id
}

resource "aws_security_group_rule" "wordpress-database-from-instance" {
  count = "${var.app_config.enabled ? 1 : 0}"

  description = "Accept traffic from instance security group"

  type      = "ingress"
  from_port = 3306
  to_port   = 3306
  protocol  = "tcp"

  security_group_id        = aws_security_group.wordpress_database[count.index].id
  source_security_group_id = aws_security_group.wordpress_instance[count.index].id
}

