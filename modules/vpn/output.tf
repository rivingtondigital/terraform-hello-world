# output.tf

output "destination_vpc" {
	value = aws_vpc.main.id 
}

