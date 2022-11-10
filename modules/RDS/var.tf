variable "sn_vpc_dev_priv_2a_id" {}

variable "sn_vpc_dev_priv_2b_id" {}

variable "vpc_dev_security_group_priv_id" {}

#DB Par Grp

variable "family" {
  type    = string
  default = "mysql8.0"
}

variable "charset" {
  type    = string
  default = "utf8"
}

variable "multi_az" {
  default = true
}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = "8.0.23"
}

variable "instance_class" {
  type    = string
  default = "db.t3.small"
}

variable "storage_type" {
  type    = string
  default = "gp2"
}

variable "allocated_storage" {
  type    = number
  default = 20
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