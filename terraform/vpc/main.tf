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

variable "vpc_tag_name" {
  description = "The name of the VPC"
  type        = string
}

variable "subnet_tag_name" {
  description = "The name of the subnet"
  type        = string
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.vpc_tag_name
  }
}

resource "aws_subnet" "vpc_subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.vpc.id

  tags = {
    Name = var.subnet_tag_name
  }
}

