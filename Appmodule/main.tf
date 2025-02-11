  resource "aws_instance" "app" {

  ami                    = var.ami
  vpc_security_group_ids = [aws_security_group.myappsg.id]
  subnet_id              = var.app_subnet_id
  instance_type          = var.ins_type
  key_name               = "terrakey"
  tags = {
    Name = "appserver"
  }
  }
  resource "aws_security_group" "myappsg" {
  name   = "myapp-sg"
  vpc_id = var.vpc_id
  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/20"]
  }
}

