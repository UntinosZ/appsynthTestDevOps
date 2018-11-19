# Private Hosted Zone
resource "aws_route53_zone" "private" {
  name    = "${var.zone_domain}"
  vpc_id  = "${aws_vpc.main.id}"
  comment = "${var.customer}, Managed by Terraform."

  tags {
    Customer = "${var.customer}"
  }
}

resource "aws_route53_record" "app_domain" {
  zone_id = "${aws_route53_zone.private.id}"
  name    = "${var.app_domain}"
  type    = "CNAME"
  ttl     = "5"
  records = ["${list(aws_elastic_beanstalk_environment.tfenvtest.cname)}"]
}
