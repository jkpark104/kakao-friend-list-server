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
  ami                    = "ami-0e6f2b2fa0ca704d0"
  instance_type          = "t2.micro"
  key_name               = "terraform_key_pair"
  vpc_security_group_ids = ["vpc-0cd1ac93f8441226f"]

  tags = {
    Name = "kakao_friend_list_backend"
  }
}
