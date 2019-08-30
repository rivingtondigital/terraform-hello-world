# peering.tf

data "aws_caller_identity" peer_user {
	provider		= aws.peer
}

resource "aws_vpc_peering_connection" "peering" {
  provider			= aws.self
	peer_vpc_id		= var.dest_vpc_id
	peer_owner_id	= data.aws_caller_identity.peer_user.account_id
	peer_region		= var.peer_region
	vpc_id				= aws_vpc.origin_vpc.id	
	auto_accept		= false 
}

resource	"aws_vpc_peering_connection_accepter" "peer_accept" {
	provider									= aws.peer
	vpc_peering_connection_id	= aws_vpc_peering_connection.peering.id
	auto_accept								= true
}


