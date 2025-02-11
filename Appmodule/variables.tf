variable "ami" {
    type = string
}
variable "ins_type" {
 type = string
 default = "t2.micro"
}
variable "key_name" {
 type = string
}
variable "vpc_id" {
  type = string
}
variable "app_subnet_id" {
  type = string
}
