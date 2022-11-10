
# Criação da VPC

resource "aws_vpc" "vpc_dev" {
  cidr_block           = "${var.vpc_dev_cidr}"
  enable_dns_hostnames = "${var.vpc_dev_dns_hostname}"
  enable_dns_support =  "${var.vpc_dev_dns_support}"

  tags = {
    "Name" = "vpc-dev"
  }
}



# Criação do Internet Gateway
resource "aws_internet_gateway" "igw_vpc_dev" {
  vpc_id = aws_vpc.vpc_dev.id

  tags = {
    "Name" = "igw_vpc_dev"
  }
}


# Criação da Tabela de roteamento Pública

resource "aws_route_table" "vpc_dev_route_table_pub" {
    vpc_id = aws_vpc.vpc_dev.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw_vpc_dev.id
    }

    tags = {
        Name = "vpc_dev_route_table_pub"
    }
}

# Criação da Tabela de roteamento Privada

resource "aws_route_table" "vpc_dev_route_table_priv" {
    vpc_id = aws_vpc.vpc_dev.id

    tags = {
        Name = "vpc_dev_route_table_priv"
    }
}





# Criação da Subnet Pública US-EAST-1A

resource "aws_subnet" "sn_vpc_dev_pub_1a" {
  vpc_id                  = aws_vpc.vpc_dev.id
  cidr_block              = "${var.sn_vpc_dev_pub_1a_cidr}"
  map_public_ip_on_launch = "${var.vpc_sn_pub_map_public_ip_on_launch}"
  availability_zone       = "us-east-1a"

  tags = {
    "Name" = "sn_vpc_dev_pub_1a"
  }
}

# Associação da Subnet Pública 1A
resource "aws_route_table_association" "association_pub_1a" {
  subnet_id      = aws_subnet.sn_vpc_dev_pub_1a.id
  route_table_id = aws_route_table.vpc_dev_route_table_pub.id
}





# Criação da Subnet Pública US-EAST-1B

resource "aws_subnet" "sn_vpc_dev_pub_1b" {
  vpc_id                  = aws_vpc.vpc_dev.id
  cidr_block              = "${var.sn_vpc_dev_pub_1b_cidr}"
  map_public_ip_on_launch = "${var.vpc_sn_pub_map_public_ip_on_launch}"
  availability_zone       = "us-east-1b"

  tags = {
    "Name" = "sn_vpc_dev_pub_1b"
  }
}

# Associação da Subnet Pública 1B
resource "aws_route_table_association" "association_pub_1b" {
  subnet_id      = aws_subnet.sn_vpc_dev_pub_1b.id
  route_table_id = aws_route_table.vpc_dev_route_table_pub.id
}





# Criação da Subnet Privada US-EAST-1A

resource "aws_subnet" "sn_vpc_dev_priv_1a" {
  vpc_id                  = aws_vpc.vpc_dev.id
  cidr_block              = "${var.sn_vpc_dev_priv_1a_cidr}"
  availability_zone       = "us-east-1a"

  tags = {
    "Name" = "sn_vpc_dev_priv_1a"
  }
}

# Associação da Subnet Privada 1A
resource "aws_route_table_association" "association_priv_1a" {
  subnet_id      = aws_subnet.sn_vpc_dev_priv_1a.id
  route_table_id = aws_route_table.vpc_dev_route_table_priv.id
}



resource "aws_subnet" "sn_vpc_dev_priv_2a" {
  vpc_id                  = aws_vpc.vpc_dev.id
  cidr_block              = "${var.sn_vpc_dev_priv_2a_cidr}"
  availability_zone       = "us-east-1a"

  tags = {
    "Name" = "sn_vpc_dev_priv_2a"
  }
}

# Associação da Subnet Privada 2A
resource "aws_route_table_association" "association_priv_2a" {
  subnet_id      = aws_subnet.sn_vpc_dev_priv_2a.id
  route_table_id = aws_route_table.vpc_dev_route_table_priv.id
}





# Criação da Subnet Privada US-EAST-1B

resource "aws_subnet" "sn_vpc_dev_priv_1b" {
  vpc_id                  = aws_vpc.vpc_dev.id
  cidr_block              = "${var.sn_vpc_dev_priv_1b_cidr}"
  availability_zone       = "us-east-1b"

  tags = {
    "Name" = "sn_vpc_dev_priv_1b"
  }
}

# Associação da Subnet Privada 1B
resource "aws_route_table_association" "association_priv_1b" {
  subnet_id      = aws_subnet.sn_vpc_dev_priv_1b.id
  route_table_id = aws_route_table.vpc_dev_route_table_priv.id
}


resource "aws_subnet" "sn_vpc_dev_priv_2b" {
  vpc_id                  = aws_vpc.vpc_dev.id
  cidr_block              = "${var.sn_vpc_dev_priv_2b_cidr}"
  availability_zone       = "us-east-1b"

  tags = {
    "Name" = "sn_vpc_dev_priv_2b"
  }
}

# Associação da Subnet Privada 1B
resource "aws_route_table_association" "association_priv_2b" {
  subnet_id      = aws_subnet.sn_vpc_dev_priv_2b.id
  route_table_id = aws_route_table.vpc_dev_route_table_priv.id
}



# Criação do Security Group Pública

resource "aws_security_group" "vpc_dev_security_group_pub" {
  name        = "vpc_dev_security_group_pub"
  description = "vpc Dev Security Group pub"
  vpc_id      = aws_vpc.vpc_dev.id

  egress {
      description = "All to All"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      description = "All from 10.0.0.0/16"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
      description = "TCP/22 from all"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      description = "TCP/80 from all"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc Dev Security Group pub"
  }
}


#Security Group privado

resource "aws_security_group" "vpc_dev_security_group_priv" {
  name        = "vpc_dev_security_group_priv"
  description = "vpc Dev Security Group priv"
  vpc_id      = aws_vpc.vpc_dev.id

  ingress {
      description = "All from 10.0.0.0/16"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
      description = "TCP/22 from 10.0.0.0/16"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
  }


  ingress {
      description = "TCP/80 from 10.0.0.0/16"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
      description = "All to 10.0.0.0/16"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["10.0.0.0/16"]
  }

}
