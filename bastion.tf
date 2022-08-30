#sg 

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_key_pair" "publickey" {
  key_name   = "stage-pubkey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCYKeUMMBgSnrhNA4ME9DQx50m1FoPfNBks0bs5fEd/y8+nm1oh3MhChIpUtF7xIM7vmmQn8d0Yc0DItX7WXmQ1YG5QNg20pz51bRsFMJKo/JU4tnR9H/Gi5qMjqu9+Xq660CrnF/OrSpkXiu3iD/OjZckObLFDG6jtN8PmzNW+fPNnydu1hBGOyx3m2U/3H7LYhsnfLxY5Vgo0NGGpyfkt7HZxsHEfmg2JrM5I5P/BWUfb3GCBhWkq7wcTNAyq5X5XnG2Pp4w5kjXuyRySESoexGAc87PYX6VXfE27DOGGzkueIOtFJx9NMAHYVogdxDL94rZVs1TJgybyuEnH70EH knolly@KNOLSKAPE-L100"

  tags = {
    Name        = "${var.name}-pubkey"
    Project     = var.project,
    Environment = var.environment

  }
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


resource "aws_instance" "bastion" {
  ami                         = "ami-06489866022e12a14"
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.bastion.id]
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public[0].id
  key_name                    = aws_key_pair.publickey.id

  lifecycle {
    ignore_changes  = all
    prevent_destroy = true
  }

  tags = merge(
    {
      Name        = "Bastion"
      Project     = var.project,
      Environment = var.environment

    },
    var.tags
  )
}