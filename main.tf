terraform {
  required_version = "~> 1.1"
  required_providers {
    aws = {
      version = "~>3.1"
    }
  }
}
provider "aws" {
  region     = var.region
  access_key = var.access
  secret_key = var.secret
}
resource "aws_key_pair" "tf-key-pair" {
  key_name   = "terrakey"
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "terrakey"
}

module "network" {
  source = "./vpcmodule"
}

module "web" {
  source        = "./webmodule"
  key_name      = "terrakey"
  ami          = var.ami
  vpc_id        = module.network.vpc_id
  web_subnet_id = module.network.web_subnet_id
}

module "app" {
  source       = "./appmodule"
  ami          = var.ami
  key_name     = "terrakey"
  vpc_id       = module.network.vpc_id
  app_subnet_id = module.network.app_subnet_id
}

module "db" {
  source       = "./dbmodule"
  vpc_id       = module.network.vpc_id
  db_subnet_ids = [module.network.db_subnet_id_1, module.network.db_subnet_id_2]
}
