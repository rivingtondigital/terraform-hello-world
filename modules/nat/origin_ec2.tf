data "aws_ami" "ubuntu" {
  provider    = aws.self
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  owners = ["099720109477"] 
}

resource "aws_instance" "origin_ec2"{
  provider        = aws.self
  ami             = data.aws_ami.ubuntu.id  
  instance_type   = var.instance_type 
  subnet_id       = aws_subnet.origin_subnet.id
  key_name        = var.key_name
  security_groups = [aws_security_group.origin_sec.id]
}

resource "aws_eip" "pub_nic" {
  provider  = aws.self
  instance  = aws_instance.origin_ec2.id
  vpc       = true
}

