# variables.tf

variable "self_region"{
	description		= "the endpoint region"
	default				= "ap-southeast-1"
}

variable "peer_region"{
	description		= "the target region"
	default				= "us-east-1"
}

variable "instance_type"{
	description		= "how big"
	default				= "t2.micro"
}

variable "key_name" {
	description		= "key pair to use"
	default			  = "singapore_micro"
}

variable "fqdn" {
	description		= "domain for this service"
	default				= "nat.rdig.co"
}

variable "dest_vpc_id" {
	description		= "vpc to peer to"
	default				= "Nope"
}

variable "dest_service" {
	description		= "doesn't matter. just a dependency"
	default				= "Whatever"
}

