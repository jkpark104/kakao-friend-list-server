
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

variable "app_name" {
  description = "The name of the CodeDeploy application."
  type        = string
}

variable "deployment_group_name" {
  description = "The name of the CodeDeploy deployment group."
  type        = string
}

variable "service_role_arn" {
  description = "The ARN of the IAM role to use for this deployment group."
  type        = string
}

variable "ec2_instance_name" {
  description = "The name of the EC2 instance to deploy to."
  type        = string
}

resource "aws_codedeploy_app" "code_deploy" {
  name             = var.app_name
  compute_platform = "Server"  
}

resource "aws_codedeploy_deployment_group" "deployment_group" {
  app_name              = aws_codedeploy_app.code_deploy.name
  deployment_group_name = var.deployment_group_name
  service_role_arn      = var.service_role_arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      value = var.ec2_instance_name
      type  = "KEY_AND_VALUE"
    }
  }

  deployment_style {
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

  deployment_config_name = "CodeDeployDefault.AllAtOnce"
}
