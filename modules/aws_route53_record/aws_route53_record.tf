resource "aws_route53_record" "record" {
  zone_id = "${var.route53_zone_id}"
  name    = "${var.route53_zone_name}"
  type    = "${var.type}"

  alias {
    zone_id                = "${var.zone_id}"
    name                   = "${var.website_domain}"
    evaluate_target_health = "${var.evaluate_target_health}"
  }
}
