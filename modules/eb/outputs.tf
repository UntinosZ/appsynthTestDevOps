output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "vpc_cidr" {
  value = "${aws_vpc.main.cidr_block}"
}

output "region" {
  value = "${var.region}"
}

output "app_domain" {
  value = "${aws_route53_record.app_domain.name}"
}

output "customer" {
  value = "${var.customer}"
}
