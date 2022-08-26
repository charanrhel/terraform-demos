#sg 

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}


resource "aws_security_group" "bastion" {
  name        = "allow ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "ssh for admin"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    {
      Name        = "${var.name}-Bastion-sg"
      Project     = var.project,
      Environment = var.environment

    },
    var.tags
  )
}