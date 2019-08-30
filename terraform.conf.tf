terraform {
  required_version = ">= 0.12"
	backend	"s3" {
		bucket  = "co.rdig.tf.state"
		key     = "origin_bastion-state"
		region  = "us-west-2"
	}
}

