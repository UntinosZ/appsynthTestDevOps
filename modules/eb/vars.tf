variable "customer" {}

variable "description" {}

variable "vpc_cidr" {}

variable "region" {}

variable "availability_zones" {
  type = "list"
}

variable "key_name" {}

variable "s3_bucket_name" {}

variable "instance_type" {}

variable "app_domain" {}

variable "zone_domain" {}

variable "autoscale_min" {}

variable "autoscale_max" {}

variable "root_volume_size" {}

variable "root_volume_type" {}

variable "autoscale_measure_name" {}

variable "autoscale_statistic" {}

variable "autoscale_unit" {}

variable "autoscale_lower_bound" {}

variable "autoscale_lower_increment" {}

variable "autoscale_upper_bound" {}

variable "autoscale_upper_increment" {}

variable "ssh_listener_port" {}

variable "ssh_listener_enabled" {}

variable "force_destroy_s3" {}