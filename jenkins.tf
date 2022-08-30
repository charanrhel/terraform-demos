
# resource "aws_security_group" "jenkins" {
#   name        = "allow jenkins"
#   description = "Allow jenkins inbound traffic"
#   vpc_id      = aws_vpc.vpc.id

#   ingress {
#     description     = "ssh for admin"
#     from_port       = 22
#     to_port         = 22
#     protocol        = "tcp"
#     security_groups = [aws_security_group.bastion.id]
#   }

#   ingress {
#     description     = "httpd for alb"
#     from_port       = 8080
#     to_port         = 8080
#     protocol        = "tcp"
#     security_groups = [aws_security_group.alb.id]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = merge(
#     {
#       Name        = "${var.name}-jenkins-sg"
#       Project     = var.project,
#       Environment = var.environment

#     },
#     var.tags
#   )
#   depends_on = [
#     aws_security_group.alb, aws_security_group.bastion
#   ]
# }


# resource "aws_instance" "jenkins" {
#   ami                         = "ami-06489866022e12a14"
#   instance_type               = "t2.micro"
#   security_groups             = [aws_security_group.jenkins.id]
#   associate_public_ip_address = true
#   subnet_id                   = aws_subnet.public[0].id
#   user_data = "${file("scripts/userdata-jenkins.sh")}"

#     key_name = aws_key_pair.publickey.id

#     lifecycle {
#       create_before_destroy = true
#     }


#   tags = merge(
#     {
#       Name        = "jenkins"
#       Project     = var.project,
#       Environment = var.environment

#     },
#     var.tags
#   )
# }