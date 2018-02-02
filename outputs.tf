output "cloudfront_distribution_id" {
  value = "${aws_cloudfront_distribution.web.id}"
}

output "web_bucket_id" {
  value = "${aws_s3_bucket.web.id}"
}

output "log_bucket_id" {
  value = "${aws_s3_bucket.log.id}"
}