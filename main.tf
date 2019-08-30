# main.tf

module "destination" {
	source	= "./modules/vpn"

	project_name	= "nat_or_ec2"
	region				= "us-west-1"
	instance_type	= "t2.micro"
	key_name			= "micro-us_west1"
	public_fqdn		= "dest.rdig.co"
	private_fqdn	= "dest.rdig.local"
}

module "origin" {
	source				= "./modules/nat"
	providers			= {
		self			= aws.origin
		peer			= aws
	}
	self_region		= "ap-southeast-1" 
	peer_region		= "us-west-1"
	instance_type	= "t2.micro"
	key_name			= "singapore_micro"
	fqdn					= "origin1.rdig.co"
	dest_vpc_id		= module.destination.destination_vpc
}

