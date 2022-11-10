# Vars customizadas do modulo network

variable "vpc_dev_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_sn_az1" {
    type    = string
    default = "us-east-1a"
}

variable "vpc_sn_az2" {
    type    = string
    default = "us-east-1b"
}



variable "sn_vpc_dev_pub_1a_cidr" {
    type = string
    default = "10.0.101.0/24"
}

variable "sn_vpc_dev_pub_1b_cidr" {
    type = string
    default = "10.0.102.0/24"
}

variable "sn_vpc_dev_priv_1a_cidr" {
    type = string
    default = "10.0.1.0/24"
}

variable "sn_vpc_dev_priv_1b_cidr" {
    type = string
    default = "10.0.2.0/24"
}

variable "sn_vpc_dev_priv_2a_cidr" {
    type = string
    default = "10.0.3.0/24"
}

variable "sn_vpc_dev_priv_2b_cidr" {
    type = string
    default = "10.0.4.0/24"
}

variable "rds_name" {
  type    = string
  default = "application"
}

variable "rds_user" {
  type    = string
  default = "challenge"
}

variable "rds_password" {
  type    = string
  default = "challenge123"
}