terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "kakao_friend_list_backend" {
  ami                         = "ami-0e6f2b2fa0ca704d0"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.terraform_key_pair.key_name
  associate_public_ip_address = true
}

resource "tls_private_key" "terraform_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "terraform_key_pair" {
  key_name   = "terraform_key_pair"
  public_key = tls_private_key.terraform_private_key.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.terraform_private_key.private_key_pem
  filename = "~/.ssh/terraform_key_pair.pem"
}
