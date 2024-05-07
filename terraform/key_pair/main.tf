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

variable "key_pair_name" {
  description = "The name of the key pair"
  type        = string
}

resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "aws_key_pair" "key_piar" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.key_pair.public_key_openssh
}
