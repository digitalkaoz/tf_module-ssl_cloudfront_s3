resource "aws_s3_bucket" "web" {
  bucket = "web.${var.domain}"
  logging {
    target_bucket = "${aws_s3_bucket.log.id}"
    target_prefix = "s3/"
  }

  tags {
    Site = "${var.domain}"
  }
}

resource "aws_s3_bucket" "log" {
  bucket = "log.${var.domain}"
  acl = "log-delivery-write"

  tags {
    Site = "${var.domain}"
  }
}

resource "aws_s3_bucket_policy" "web" {
  bucket = "${aws_s3_bucket.web.id}"
  policy = <<POLICY
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_cloudfront_origin_access_identity.oai.iam_arn}"
            },
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.web.arn}/*"
        }
    ]
}
POLICY
}
