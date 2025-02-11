variable "ins_type" {
 type = string
 default = "t2.micro"
}
variable "ami" {
  type = string
}
variable "key_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "web_subnet_id" {
  type = string
}
