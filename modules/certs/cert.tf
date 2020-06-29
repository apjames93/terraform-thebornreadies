resource "aws_iam_server_certificate" "ssl_cert" {
  name_prefix       = var.name
  certificate_body  = file(var.certificate_body_path)
  certificate_chain = file(var.cert_chain)
  private_key       = file(var.private_key_path)
  path              = "/cloudfront/"

  lifecycle {
    create_before_destroy = true
  }
}
