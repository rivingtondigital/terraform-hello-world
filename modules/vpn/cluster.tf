data "aws_ami" "ecs_optimized_ami" {
	owners	= ["amazon"]
	filter {
		name		= "name"
		values	= ["amzn2-ami-ecs-hvm-2.0.20190709-x86_64-ebs"]
	}
}


resource "aws_launch_configuration" "ecs_launch" {
	name_prefix									= "ecs-launch-config-"
	image_id										= data.aws_ami.ecs_optimized_ami.id 
	instance_type								= var.instance_type
	iam_instance_profile				= aws_iam_instance_profile.ecs_agent.name
	security_groups							= [aws_security_group.ecs_ec2.id]
	root_block_device {
		volume_type 					= "standard"
		volume_size						= 30
		delete_on_termination	= true
	}

	lifecycle {
		create_before_destroy = true
	}
	associate_public_ip_address = "true"
	key_name										= var.key_name 
	user_data										= <<EOF
                                  #!/bin/bash
                                  echo ECS_CLUSTER=${var.project_name} >> /etc/ecs/ecs.config
                                  EOF


}

resource "aws_autoscaling_group" "ec2_pool" {
	name									= "ec2_pool"
	vpc_zone_identifier		= [aws_subnet.public.id]
	launch_configuration	= aws_launch_configuration.ecs_launch.name
	force_delete					= true

	desired_capacity			= 1
	min_size							= 1
	max_size							= 2
}

resource "aws_ecs_cluster" "main" {
	name = var.project_name
	tags = {
		Name	= var.project_name				
	}
}

