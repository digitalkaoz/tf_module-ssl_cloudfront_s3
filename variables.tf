variable "domain" {
  description = "the domain for this cf+s3 application"
}

variable "certdomain" {
  description = "the certificate"
  default = ""
}

variable "mx_hosts" {
  type = "list"
  description = "the mx hosts for this domain"
  default = []
}

variable "region" {
  description = "the aws region to deploy to"
  default = "eu-central-1"
}
