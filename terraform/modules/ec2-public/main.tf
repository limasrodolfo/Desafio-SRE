resource "aws_security_group" "ssh_conection" {
  name = "${var.application_name}-ssh_conection"
  vpc_id = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


resource "aws_instance" "ec2" {
  count = 2
  ami = "ami-0261755bbcb8c4a84"
  instance_type = "t2.micro"
  subnet_id = count.index % 2 == 0 ? split(",", var.subnet_id)[0] : split(",", var.subnet_id)[1]
  associate_public_ip_address = true
  key_name = "desafio"
  security_groups = [aws_security_group.ssh_conection.id]
  
  tags = {
    "Name" = "${var.application_name}-ec2-public-${count.index + 1}"
  }
}