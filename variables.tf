# variables.tf

variable "project_name"{
	description	= "a regional jump off point"
	default			= "origin_bastion"
}

variable "dest_region"{
	description		= "the target endpoint"
	default				= "us-west-1"
}

variable "origin_region"{
	description		= "the region of origin"
	default				= "ap-southeast-1"
}

variable "instance_type"{
	description		= "how big"
	default				= "t2.micro"
}

variable "key_name" {
	description		= "key pair to use"
	default			  = "singapore_micro"
}
