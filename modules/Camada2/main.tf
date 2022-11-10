


#Load Balancer
resource "aws_lb_target_group" "tg_alb_application2" {
  name     = "tg-alb-camada2"
  vpc_id   = "${var.vpc_id}"
  protocol = "${var.protocol}"
  port     = "${var.port}"

  tags = {
    Name = "tg-alb-application2"
  }
}

resource "aws_lb_listener" "listener_alb_application2" {
  load_balancer_arn = aws_lb.elb_application2.arn
  protocol          = "${var.protocol}"
  port              = "${var.port}"

  default_action {
      type             = "${var.ec2_lb_listener_action_type}"
      target_group_arn = aws_lb_target_group.tg_alb_application2.arn
  }
}

resource "aws_lb" "elb_application2" {
  name               = "elb-application2"
  load_balancer_type = "application"
  subnets            = ["${var.sn_vpc_dev_priv_1a_id}", "${var.sn_vpc_dev_priv_1b_id}"]
  security_groups    = ["${var.vpc_dev_security_group_priv_id}"]

  tags = {
    Name = "elb-application2"
  }
}

#Ec2 template
data "template_file" "user_data2" {
  template = "${file("./modules/Camada2/userdata2.sh")}"
  vars = {
      rds_endpoint = "${var.rds_endpoint}"
      rds_user     = "${var.rds_user}"
      rds_password = "${var.rds_password}"
      rds_name     = "${var.rds_name}"
  }
}

resource "aws_launch_template" "template_ASG2" {
  name = "template_ASG2"
  image_id               = "${var.ami}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${var.vpc_dev_security_group_priv_id}"]
  key_name               = "${var.ssh_key}"
  user_data              = "${base64encode(data.template_file.user_data.rendered)}"

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Camada2"
    }
  }

  tags = {
        Name = "template_ASG2"
    }
}

# Auto Scaling
resource "aws_autoscaling_group" "autoscaling2" {
  name                = "AutoScalingGroup2"
  vpc_zone_identifier = ["${var.sn_vpc_dev_priv_1a_id}", "${var.sn_vpc_dev_priv_1b_id}"]
  desired_capacity    = "${var.desired_capacity}"
  min_size            = "${var.min_size}"
  max_size            = "${var.max_size}"
  target_group_arns   = [aws_lb_target_group.tg_alb_application2.arn]

  launch_template {
    id      = aws_launch_template.template_ASG2.id
    version = "$Latest"
  }
}