# variables.tf

variable "project_name"{
	description = "both the name of the project and the ecs cluster"
	default			= "ecs_ec2"
}

variable "region" {
	description	= "aws region"
	default			= "us-west-1"
}

variable "app_image" {
	description	= "docker image for app"
  default     = "256782092976.dkr.ecr.us-east-1.amazonaws.com/base_init" 
}

variable "ecs_task_role_name" {
	description	= "role name for ecs host to call ecs tasks"
	default			= "rdigECSTasksRole"
}

variable "host_ports" {
	description	= "the ports open on the ec2 host"
	default			= [443, 22]
}

variable	"container_ports"{
	description	= "the ports open in the container"
	default			= [1194] 
}

variable "instance_type" {
	description	= "the size of ec2 instances in the ecs cluster"
	default			= "t2.micro"
}

variable	"key_name" {
	description	= "the key-pair to use for instance deployment"
	default			= "singapore_micro"
}

variable	"public_fqdn" {
	description = "the dns name to assign to this service"
	default			= "service.rdig.co"
}

variable	"private_fqdn" {
	description = "the private dns name to assign to this service"
	default			= "service.rdig.local"
}

