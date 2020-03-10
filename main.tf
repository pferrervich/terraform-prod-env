terraform {
  required_version = ">= 0.10.7"
}

provider "aws" {
  region  = "${var.region}"
  profile = "aperture"
}

# Datasource to get available zones
data "aws_availability_zones" "avazones" {}
