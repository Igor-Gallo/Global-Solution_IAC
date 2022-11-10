
# Configuração do Bloco de Terraform

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0" /* Opcional, porém recomendado para ambiente de produção */
    }
  }
  backend "s3" {
    bucket = "bucket-auditoria-terraform"
    key    = "auditoria"
    region = "us-east-1"
  }
}

# Configuração da região utilizada na AWS
provider "aws" {
  region = var.region_aws
}


/*-------------------------------------------
                 VPC Modules                
-------------------------------------------*/

module "VPC" {
  source  = "./modules/VPC"
  vpc_dev_cidr = "${var.vpc_dev_cidr}"
  vpc_sn_az1  = "${var.vpc_sn_az1}"
  vpc_sn_az2  = "${var.vpc_sn_az2}"
  sn_vpc_dev_priv_1a_cidr = "${var.sn_vpc_dev_priv_1a_cidr}"
  sn_vpc_dev_priv_1b_cidr = "${var.sn_vpc_dev_priv_1b_cidr}"
  sn_vpc_dev_priv_2a_cidr = "${var.sn_vpc_dev_priv_2a_cidr}"
  sn_vpc_dev_priv_2b_cidr = "${var.sn_vpc_dev_priv_2b_cidr}"
  sn_vpc_dev_pub_1a_cidr = "${var.sn_vpc_dev_pub_1a_cidr}"
  sn_vpc_dev_pub_1b_cidr = "${var.sn_vpc_dev_pub_1b_cidr}"
}



module "Camada1" {
  source  = "./modules/Camada1"
  vpc_id = "${module.VPC.vpc_dev_id}"
  rds_endpoint = "${module.RDS.rds_endpoint}"
  rds_name = "${var.rds_name}"
  rds_user = "${var.rds_user}"
  rds_password = "${var.rds_password}"
  sn_vpc_dev_pub_1a_id = "${module.VPC.sn_vpc_dev_pub_1a_id}"
  sn_vpc_dev_pub_1b_id = "${module.VPC.sn_vpc_dev_pub_1b_id}"
  vpc_dev_security_group_pub_id = "${module.VPC.vpc_dev_security_group_pub_id}"
}



#module "RDS" {
  #source  = "./Modules/RDS"
 # sn_vpc_dev_pub_1a_id = "${module.VPC.sn_vpc_dev_pub_1a_id}"
  #sn_vpc_dev_pub_1b_id = "${module.VPC.sn_vpc_dev_pub_1b_id}"
  #vpc_dev_security_group_priv_id = "${module.VPC.vpc_dev_security_group_priv_id}"

#}