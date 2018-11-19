resource "aws_security_group" "http" {
  name   = "${var.customer}-http"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.elb.id}"]
  }
  tags {
    Customer = "${var.customer}"
  }
}

resource "aws_security_group" "elb" {
  name   = "${var.customer}-elb"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Customer = "${var.customer}"
  }
}
