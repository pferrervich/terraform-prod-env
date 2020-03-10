# default region
variable "aws_region" {
  type    = "string"
  default = "eu-west-1"
}

# vpc ip
variable "cidr" {
  type    = "string"
  default = "10.0.0.0/16"
}

## subnets ##
variable "pub1_cidr" {
  type    = "string"
  default = "10.0.0.0/24"
}

variable "pub2_cidr" {
  type    = "string"
  default = "10.0.1.0/24"
}

variable "pri1_cidr" {
  type    = "string"
  default = "10.0.10.0/24"
}

variable "pri2_cidr" {
  type    = "string"
  default = "10.0.11.0/24"
}

variable "instance_type" {
  type    = "string"
  default = "t2.micro"
}
## /subnets ##

# Default region
variable "region" {
  type    = "string"
  default = "eu-west-1"
}

# Uses N image depending on zone
variable "aws_amis" {
  type = "map"
  default = {
    "eu-west-1"    = "ami-099a8245f5daa82bf"
    "us-east"      = "ami-0a887e401f7654935"
    "eu-central-1" = "ami-0df0e7600ad0913a9"
  }
}

# Project name
variable "project" {
  type    = "string"
  default = "ap"
}

# environment
variable "environment" {
  type    = "string"
  default = "prod"
}

# database username (TODO: Change hardcode for prod)
variable "rds_username" {
  type = "string"
  default = "root"
}

# database password (TODO: Change hardcode for prod)
variable "rds_passwd" {
  type = "string"
  default = "123QWEasd"
}
