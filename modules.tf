################################################################################
############################### SETUP ##########################################
################################################################################

# Specify the provider and access details
provider "aws" {
  version = "~> 2.15.0"

  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "default"
  region                  = "us-west-2"
}

################################################################################
############################### aws_route53_zone  ###########################
################################################################################
data "aws_route53_zone" "wre" {
  name         = "thebornreadies.rocks"
  private_zone = false
}

################################################################################
############################### CERTS  ########################################
################################################################################
module "cert" {
  source                = "./modules/certs"
  name                  = "cert"
  certificate_body_path = "ssl_certs/crt/cert.crt"
  cert_chain            = "ssl_certs/crt/cert-chain.crt"
  private_key_path      = "ssl_certs/key/cert.key"
}
################################################################################
############################### S3 thebornreadies ##############################
################################################################################

module "s3_thebornreadies" {
  source         = "./modules/s3"
  bucket         = "thebornreadies.rocks"
  acl            = "public-read"
  index_document = "index.html"
  error_document = "index.html"
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity_react" {
  comment = "thebornreadies"
}

module "cloudfront_thebornreadies" {
  source                 = "./modules/aws_cloudfront_distribution"
  domain_name            = module.s3_react.bucket_regional_domain_name
  origin_id              = "cloudfront_thebornreadies"
  origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity_react.cloudfront_access_identity_path
  iam_certificate_id     = module.cert.id
  environment_tag        = "thebornreadies"

  aliases = [
    "thebornreadies",
  ]
}

################################################################################
############################### ROUTE53  #######################################
################################################################################

module "route53_record_thebornreadies" {
  source            = "./modules/aws_route53_record"
  route53_zone_id   = data.aws_route53_zone.wre.zone_id
  route53_zone_name = "thebornreadies.rocks"
  zone_id           = module.cloudfront_thebornreadies.hosted_zone_id
  website_domain    = module.cloudfront_thebornreadies.domain_name
  type              = "A"
}

