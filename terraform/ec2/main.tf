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

resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0e6f2b2fa0ca704d0"
  instance_type          = "t2.micro"
  key_name               = var.key_pair_name
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apt-transport-https ca-certificates curl software-properties-common
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
              add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
              apt-get update
              apt-get install -y docker-ce docker-ce-cli containerd.io
              systemctl start docker
              systemctl enable docker

              # Docker Compose 설치
              curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              chmod +x /usr/local/bin/docker-compose

              # Docker Compose 환경 변수 설정
              echo "export DOCKER_COMPOSE_VERSION=1.29.2" >> /etc/profile

              # AWS CodeDeploy Agent 설치
              apt-get install -y ruby wget
              cd /home/ubuntu
              wget https://aws-codedeploy-ap-northeast-2.s3.amazonaws.com/latest/install
              chmod +x ./install
              ./install auto
              EOF

  tags = {
    Name = var.ec2_instance_name
  }
}
