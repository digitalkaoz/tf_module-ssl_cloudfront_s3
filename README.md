# AWS Cloudfront-S3 Terraform Module

* creates a dedicated Domain (with Subdomain support)
* attaches SSL for your domain (must already exist)
* secured private Bucket

## Usage

> a certificate for your domain should already be deployed (cant be automated by terraform as of now)

```hcl
module "ssl_cloudfront_s3" {
  source = "github.com/digitalkaoz/tf_module-ssl_cloudfront_s3"

  domain = "digitalkaoz.net"   # the domain to deploy
  certdomain = ""              # provide a valid main domain in case of "domain" is a subdomain
  mx_hosts = []                # if its not a subdomain fill in for email domain validation e.g. "10 mail.host.com"
  region = "eu-central-1"      # the aws region

  providers = {                # explicitly pass the providers
    aws = "aws"                # can be inherited from the outer scope, provider "aws" is default
    aws.west = "aws.west"      # provider "aws.west" must exists
  }
}
```

#TODO

* `kms` encryption for bucket?
* automated cert creation