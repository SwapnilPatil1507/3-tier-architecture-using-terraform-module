resource "aws_instance" "web" {

  ami                    = var.ami
  vpc_security_group_ids = [aws_security_group.mywebsg.id]
  instance_type          = var.ins_type
  subnet_id = var.web_subnet_id

  key_name               = "terrakey"
  associate_public_ip_address = true
  tags = {
    Name = "webserver"
  }
}
resource "aws_security_group" "mywebsg" {
  name   = "myweb-sg"
  vpc_id = var.vpc_id

  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    to_port     = 22
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  # Allow inbound HTTP (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

