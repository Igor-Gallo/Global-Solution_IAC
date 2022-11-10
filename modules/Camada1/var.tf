

variable "vpc_id" {}

variable "rds_endpoint" {}

variable "rds_dbuser" {}

variable "rds_dbpassword" {}

variable "rds_dbname" {}
  
#Load Balancer

variable "protocol" {
  type = string
  default = "HTTP"
}

variable "port" {
  type = number
  default = 80
}

variable "sn_vpc_dev_pub_1a_id" {}

variable "sn_vpc_dev_pub_1b_id" {}

variable "vpc_dev_security_group_pub_id" {}


variable "ami" {
  type    = string
  default = "ami-02e136e904f3da870"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ssh_key" {
  type    = string
  default = "vockey"
}

#Auto Scaling
variable "desired_capacity" {
  type    = number
  default = 2
}

variable "min_size" {
  type    = number
  default = 1
}

variable "max_size" {
  type    = number
  default = 4
}

variable "ec2_lb_listener_action_type" {
    type    = string
    default = "forward"
}