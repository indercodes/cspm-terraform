terraform {
#  backend "s3" {
#    bucket = "terraform-state-github-actions"
#    key    = "terraform/terraform-aws-security-group"
#    region = "ap-south-1"
#  }
backend "remote" {
    organization = "devocops"
    workspaces {
      name = "github-actions-terraform"
      }
}
}

provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source      = "clouddrove/vpc/aws"
  version     = "0.15.0"
  name        = "vpc"
  environment = "test"
  label_order = ["name", "environment"]
  cidr_block  = "10.0.0.0/16"
}

module "security_group_tcp" {
  source        = "clouddrove/security-group/aws"
  version       = "0.15.0"
  name          = "security-group"
  environment   = "tcp"
  protocol      = "tcp"
  label_order   = ["name", "environment"]
  vpc_id        = module.vpc.vpc_id
  allowed_ip    = ["0.0.0.0/0"]
  allowed_ipv6  = ["::/0"]
  allowed_ports = [20, 21, 22, 23, 25, 445, 1433, 3389, 4333, 3306, 5432, 5500, 5900, 1521, 5601, 8020, 50070, 50470, 4505, 4506, 2375, 2376, 53]
}

module "security_group_udp" {
  source        = "clouddrove/security-group/aws"
  version       = "0.15.0"
  name          = "security-group"
  environment   = "udp"
  protocol      = "tcp"
  label_order   = ["name", "environment"]
  vpc_id        = module.vpc.vpc_id
  allowed_ip    = ["0.0.0.0/0"]
  allowed_ipv6  = ["::/0"]
  allowed_ports = [53, 135, 137, 138]
}
