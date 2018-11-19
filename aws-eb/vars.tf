locals {
  customer = "tf-test-eb"
}

variable "description" {
  default = "Test create Elastic Beanstalk with Terraform"
}

variable "vpc_cidr" {
  default = "10.0.33.0/25"
}

variable "region" {
  default = "ap-southeast-1"
}

variable "availability_zones" {
  default = ["ap-southeast-1a", "ap-southeast-1b"]
}

variable "key_name" {
  default = "ansible-eko-qadev"
}

variable "s3_bucket_name" {
  default = "test-eb-state"
}

variable "instance_type" {
  default = "t2.small"
}

variable "app_domain" {
  default = "dev.tftest.local"
}

variable "zone_domain" {
  default = "tftest.local"
}

variable "autoscale_min" {
  default = "1"
}

variable "autoscale_max" {
  default = "2"
}

variable "root_volume_size" {
  default = "30"
}

variable "root_volume_type" {
  default = "gp2"
}

variable "autoscale_measure_name" {
  default = "CPUUtilization"
}

variable "autoscale_statistic" {
  default = "Average"
}

variable "autoscale_unit" {
  default = "Percent"
}

variable "autoscale_lower_bound" {
  default = "20"
}

variable "autoscale_lower_increment" {
  default = "-1"
}

variable "autoscale_upper_bound" {
  default = "40"
}

variable "autoscale_upper_increment" {
  default = "1"
}

variable "force_destroy_s3" {
  default = "false"
}