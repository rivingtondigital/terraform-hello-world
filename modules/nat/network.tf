# network.tf

resource "aws_vpc" "origin_vpc"{
  provider							= aws.self
	cidr_block						= "10.1.0.0/16"
	enable_dns_hostnames	= true
}	

resource "aws_subnet" "origin_subnet"{
  provider					= aws.self
	vpc_id						= aws_vpc.origin_vpc.id
	cidr_block				= "10.1.20.0/24"
	availability_zone	= "${var.self_region}a"
}

resource "aws_internet_gateway" "origin_gw"{
  provider	= aws.self
	vpc_id		= aws_vpc.origin_vpc.id
}

resource	"aws_route" "public_access"{
  provider								= aws.self
	route_table_id					= aws_vpc.origin_vpc.main_route_table_id
	destination_cidr_block	= "0.0.0.0/0"
	gateway_id							= aws_internet_gateway.origin_gw.id
}

resource "aws_security_group" "origin_sec"{
  provider			= aws.self
	name					= "origin_sec"
	description		= "security group for origin host"
	vpc_id				= aws_vpc.origin_vpc.id

	ingress {
		protocol		= "tcp"
		from_port		= "22"
		to_port			= "22"
		cidr_blocks	= ["0.0.0.0/0"]
	}

	ingress {
		protocol		= "tcp"
		from_port		= "443"
		to_port			= "443"
		cidr_blocks	= ["0.0.0.0/0"]
	}

	egress {
		protocol		= "-1"
		from_port		= 0
		to_port			= 0
		cidr_blocks	= ["0.0.0.0/0"]
	}

}



