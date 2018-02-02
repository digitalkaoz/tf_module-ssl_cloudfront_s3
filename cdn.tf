resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "cloudfront - s3 - origin"
}

resource "aws_cloudfront_distribution" "web" {
  aliases = ["${var.domain}"]
  price_class = "PriceClass_100"
  enabled = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  origin {
    domain_name = "${aws_s3_bucket.web.bucket_domain_name}"
    origin_id   = "${var.domain}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path}"
    }
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    default_ttl = 86400
    max_ttl = 86400
    min_ttl = 3600
    target_origin_id = "${var.domain}"
    viewer_protocol_policy = "allow-all"

    "forwarded_values" {
      cookies {
        forward = "none"
      }
      query_string = false
    }
  }

  logging_config {
    include_cookies = false
    bucket          = "${aws_s3_bucket.log.bucket_domain_name}"
    prefix          = "cf/"
  }

  "restrictions" {
    "geo_restriction" {
      restriction_type = "none"
    }
  }
  "viewer_certificate" {
    acm_certificate_arn = "${data.aws_acm_certificate.cert.arn}"
    ssl_support_method = "sni-only"
  }

  tags {
    Site = "${var.domain}"
  }
}