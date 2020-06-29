resource "aws_cloudfront_distribution" "cdn" {
  origin {
    origin_id   = "${var.domain_name}"
    domain_name = "${var.domain_name}"
    s3_origin_config {
      origin_access_identity = "${var.origin_access_identity}"
    }
  }

  aliases             = "${var.aliases}"
  enabled             = true
  default_root_object = "index.html"
  is_ipv6_enabled     = true
  comment             = "terraform created ${terraform.workspace}"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.domain_name}"

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  tags = {
    Environment = "${var.environment_tag}"
  }

  viewer_certificate {
    iam_certificate_id = "${var.iam_certificate_id}"
    ssl_support_method = "sni-only"
  }

  custom_error_response {
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 5
  }
}
