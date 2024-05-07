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

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
}

resource "aws_security_group" "security_group" {
  name        = var.security_group_name
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = "vpc-0cd1ac93f8441226f"
}

resource "aws_security_group_rule" "sg_ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0/0"]
  security_group_id = aws_security_group.security_group.id
}


resource "aws_security_group_rule" "sg_ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0/0"]
  security_group_id = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "sg_ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0/0"]
  security_group_id = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "sg_ingress_custom_tcp" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0/0"]
  security_group_id = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "sg_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0/0"]
  security_group_id = aws_security_group.security_group.id
}


