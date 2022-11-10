
#Externalização das Variáveis da VPC

output "vpc_dev_id" {
  value = "${aws_vpc.vpc_dev.id}"
}

output "vpc_dev_security_group_pub_id" {
    value = "${aws_security_group.vpc_dev_security_group_pub.id}"
}

output "vpc_dev_security_group_priv_id" {
    value = "${aws_security_group.vpc_dev_security_group_priv.id}"
}


# Externalização das Variáveis de Subnet Pública

output "sn_vpc_dev_pub_1a_id" {
  value = "${aws_subnet.sn_vpc_dev_pub_1a.id}"
}

output "sn_vpc_dev_pub_1b_id" {
  value = "${aws_subnet.sn_vpc_dev_pub_1b.id}"
}

output "sn_vpc_dev_priv_1a_id" {
  value = "${aws_subnet.sn_vpc_dev_priv_1a.id}"
}

output "sn_vpc_dev_priv_1b_id" {
  value = "${aws_subnet.sn_vpc_dev_priv_1b.id}"
}

output "sn_vpc_dev_priv_2a_id" {
  value = "${aws_subnet.sn_vpc_dev_priv_2a.id}"
}

output "sn_vpc_dev_priv_2b_id" {
  value = "${aws_subnet.sn_vpc_dev_priv_2b.id}"
}