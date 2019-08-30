provider "aws"{
	profile		= "default"
	region		= var.dest_region
}

provider "aws"{
	profile		= "default"
	alias			= "origin"
	region		= var.origin_region
}

