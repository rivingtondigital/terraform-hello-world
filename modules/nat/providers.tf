provider "aws" {
	region	= var.self_region
	alias		= "self"
}

provider "aws" {
	region	= var.peer_region
	alias		= "peer"
}

