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

variable "key_pair_name" {
  description = "The name of the key pair"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group"
  type        = string
}

variable "i_am_role_name" {
  description = "The name of the IAM role"
  type        = string
}

resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0e6f2b2fa0ca704d0"
  instance_type          = "t2.micro"
  key_name               = var.key_pair_name
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile = var.i_am_role_name

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
              sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
              sudo apt-get update
              sudo apt-get install docker-ce docker-ce-cli containerd.io -y

              sudo curl -SL https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
              sudo chmod +x /usr/local/bin/docker-compose

              sudo apt update              
              sudo apt install ruby-full -y
              sudo apt install wget
              cd /home/ubuntu
              wget https://aws-codedeploy-ap-northeast-2.s3.ap-northeast-2.amazonaws.com/latest/install
              chmod +x ./install
              sudo ./install auto
              sudo service codedeploy-agent start
              EOF

  tags = {
    Name = var.ec2_instance_name
  }
}
