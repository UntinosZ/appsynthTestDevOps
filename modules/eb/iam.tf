data "aws_iam_policy_document" "ec2" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    effect = "Allow"
  }

  statement {
    sid = ""

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "s3" {
  statement {
    sid     = ""
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}",
      "arn:aws:s3:::${var.s3_bucket_name}/"
    ]
  }
}

resource "aws_iam_policy" "s3policy" {
  name   = "tftests3role"
  policy = "${data.aws_iam_policy_document.s3.json}"
}

resource "aws_iam_role" "ec2" {
  name               = "${var.customer}-ec2"
  assume_role_policy = "${data.aws_iam_policy_document.ec2.json}"
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.customer}-ec2"
  role = "${aws_iam_role.ec2.name}"
}

resource "aws_iam_role_policy_attachment" "s3attach" {
  role       = "${aws_iam_role.ec2.name}"
  policy_arn = "${aws_iam_policy.s3policy.arn}"
}