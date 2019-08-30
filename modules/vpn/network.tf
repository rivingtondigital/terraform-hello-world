# network.tf

resource "aws_vpc" "main"{
  cidr_block            = "10.0.0.0/16"
  enable_dns_hostnames  = true
  enable_dns_support    = true
} 

resource "aws_subnet" "public"{
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "${var.region}b"
}

resource "aws_internet_gateway" "gw"{
  vpc_id    = aws_vpc.main.id
}

resource  "aws_route" "public_access"{
  route_table_id          = aws_vpc.main.main_route_table_id
  destination_cidr_block  = "0.0.0.0/0"
  gateway_id              = aws_internet_gateway.gw.id
}

resource "aws_security_group" "ecs_ec2"{
  name          = "origin_sec"
  description   = "security group for origin host"
  vpc_id        = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = element(var.host_ports, 0) 
    to_port     = element(var.host_ports, 0) 
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = element(var.host_ports, 1) 
    to_port     = element(var.host_ports, 1) 
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}

