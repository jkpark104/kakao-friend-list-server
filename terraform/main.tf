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

variable "ec2_instance_name" {
  description = "The name of the EC2 instance"
  type        = string
}

resource "aws_instance" "ec2-instance" {
  ami                    = "ami-0e6f2b2fa0ca704d0"
  instance_type          = "t2.micro"
  key_name               = "terraform_key_pair"
  vpc_security_group_ids = ["sg-01c189184d271e943"]

  tags = {
    Name = var.ec2_instance_name
  }
}
