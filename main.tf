
#
# DO NOT DELETE THESE LINES UNTIL INSTRUCTED TO!
#
# Your AMI ID is:
#
#     "ami-00482f016b2410dc8"
#
# Your subnet ID is:
#   

# "subnet-075ec1c04f8d0cf50"

#
# Your VPC security group ID is:
#  

# "sg-0e82758f26af0c4f7"

#
# Your Identity is:
#
#     "awsaccount"
#


variable "access_key" {
  description = "AWS Access Key"
}

variable "secret_key" {
  description = "AWS Secret Key"
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "ami" {
  description = "Server Image ID"
}

variable "subnet_id" {
  description = "Server Subnet ID"
}

variable "identity" {
  description = "Server Name"
}

variable "vpc_security_group_ids" {
  description = "Server Security Group ID(s)"
  type        = list(any)
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}
variable bucket {}
variable acl {}

module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.5.0"

  bucket = var.bucket
  acl    = var.acl

  versioning = {
    enabled = true
  }
}
module "server" {
  source  = "app.terraform.io/terrafrom-aws/server/aws"
  version = "0.0.1"
  # insert required variables here

  ami                    = var.ami
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  identity               = var.identity
}

output "public_ip" {
  value = module.server.public_ip
}

output "public_dns" {
  value = module.server.public_dns
}

