output "cert_arn" {
  value = "${aws_iam_server_certificate.ssl_cert.arn}"
}

output "id" {
  value = "${aws_iam_server_certificate.ssl_cert.id}"
}
