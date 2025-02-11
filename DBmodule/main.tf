 resource "aws_db_subnet_group" "my_subnet_grp" {
  name       = "my-db-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "MyDBSubnetGroup"
  }
}


  resource "aws_db_instance" "myrds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "pass1234"
  vpc_security_group_ids = [aws_security_group.mydbsg.id]
  db_subnet_group_name    = aws_db_subnet_group.my_subnet_grp.name
  skip_final_snapshot  = true
}
resource "aws_security_group" "mydbsg" {
  name   = "mydb-sg"
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
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.16.0/20"]
  }
}
