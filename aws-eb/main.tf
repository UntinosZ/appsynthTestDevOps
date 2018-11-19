terraform {
  backend "s3" {
    bucket = "tf-state-secret"
    region = "ap-southeast-1"
    key    = "test-state.tfstate"
  }
}

provider "aws" {
  region = "${var.region}"
}

provider "aws" {
  region = "ap-southeast-1"
  alias  = "ap-southeast-1"
}

module "eb" {
  source                      = "../modules/eb"
  customer                    = "${local.customer}"
  description                 = "${var.description}"
  region                      = "${var.region}"
  availability_zones          = "${var.availability_zones}"
  vpc_cidr                    = "${var.vpc_cidr}"
  key_name                    = "${var.key_name}"
  # lb_ssl_certificate_id       = "${var.lb_ssl_certificate_id}"
  zone_domain                 = "${var.zone_domain}"
  s3_bucket_name              = "${var.s3_bucket_name}"
  force_destroy_s3            = "${var.force_destroy_s3}"
  app_domain                  = "${var.app_domain}"
  instance_type               = "${var.instance_type}"

  autoscale_min               = "${var.autoscale_min}"
  autoscale_max               = "${var.autoscale_max}"
  root_volume_size            = "${var.root_volume_size}"
  root_volume_type            = "${var.root_volume_type}"

  autoscale_measure_name      = "${var.autoscale_measure_name}"
  autoscale_statistic         = "${var.autoscale_statistic}"
  autoscale_unit              = "${var.autoscale_unit}"
  autoscale_lower_bound       = "${var.autoscale_lower_bound}"
  autoscale_lower_increment   = "${var.autoscale_lower_increment}"
  autoscale_upper_bound       = "${var.autoscale_upper_bound}"
  autoscale_upper_increment   = "${var.autoscale_upper_increment}"

  providers {
    # for object in s3 secret bucket
    aws.ap-southeast-1 = "aws.ap-southeast-1"
  }
}

output "customer" {
  value = "${module.eb.customer}"
}

output "region" {
  value = "${module.eb.region}"
}

output "vpc_cidr" {
  value = "${module.eb.vpc_cidr}"
}

output "app_domain" {
  value = "${module.eb.app_domain}"
}

