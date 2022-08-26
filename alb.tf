
resource "aws_security_group" "alb" {
  name        = "allow enduser"
  description = "Allow enduser inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "enduser for admin"
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

  tags = merge(
    {
      Name        = "${var.name}-Alb-sg"
      Project     = var.project,
      Environment = var.environment

    },
    var.tags
  )
}


# alb 

resource "aws_lb" "alb" {
  name               = "apache-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = true

#   access_logs {
#     bucket  = aws_s3_bucket.lb_logs.bucket
#     prefix  = "test-lb"
#     enabled = true
#   }

  tags = merge(
    {
      Name        = "${var.name}-Apache"
      Project     = var.project,
      Environment = var.environment

    },
    var.tags
  )
}

#tg 
resource "aws_lb_target_group" "http" {
  name     = "http"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

#listener 
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }
}

resource "aws_lb_target_group_attachment" "http" {
  target_group_arn = aws_lb_target_group.http.arn
  target_id        = aws_instance.apache.id
  port             = 80
}
