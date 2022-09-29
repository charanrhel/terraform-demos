resource "aws_security_group" "rds" {
  name        = "allow rds"
  description = "Allow rds inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "bastion to rds"
    from_port       = 3369
    to_port         = 3369
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  ingress {
    description     = "apache to rds"
    from_port       = 3369
    to_port         = 3369
    protocol        = "tcp"
    security_groups = [aws_security_group.apache.id]
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
      Name        = "${var.name}-Rds-sg"
      Project     = var.project,
      Environment = var.environment

    },
    var.tags
  )
  depends_on = [
    aws_security_group.apache, aws_security_group.bastion
  ]
}

#group
resource "aws_db_subnet_group" "data" {
  name       = "stagerds"
  subnet_ids = [for subnet in aws_subnet.data : subnet.id]

  tags = {
    Name = "Stage-RDS"
  }
}

resource "aws_db_instance" "mysql" {
  allocated_storage       = 50
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t3.micro"
  name                    = "mydb"
  username                = "adminuserrds"
  password                = var.db_password
  parameter_group_name    = "default.mysql5.7"
  skip_final_snapshot     = true
  backup_retention_period = 7
  maintenance_window      = "mon:10:10-mon:10:40"
  backup_window           = "09:10-09:40"
  multi_az                = true

    tags ={
      Name        = "jenkins"
      Project     = var.project,
      Environment = var.environment

    }
  
}