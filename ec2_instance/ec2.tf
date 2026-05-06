resource "aws_key_pair" "my-key" {
  key_name = "ec2-key"
  public_key = file("ec2-key.pub")
}


resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "security_group" {
  name = "ec2_security_group"
  vpc_id = aws_default_vpc.default.id

  #inbound rules
  ingress = [
  {
    description      = "SSH access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }
]
  
  # ingress = {
  #   from_port = 80
  #   to_port = 80
  #   protocol = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  #outbound rules
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

#ec2_instance

resource "aws_instance" "my_instance" {
  key_name = aws_key_pair.my-key.key_name
  security_groups = [aws_security_group.security_group.name]
  instance_type = "t3.micro"
  ami = "ami-091138d0f0d41ff90"

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name = "Terra_ec2_instance"
  }
  
}