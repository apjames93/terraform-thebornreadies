variable "route53_zone_id" {
  description = "route53_zone_id"
}

variable "route53_zone_name" {
  description = "route53_zone_name"
}

variable "zone_id" {
  description = "s3_zone_id"
}

variable "website_domain" {
  description = "s3_website_domain"
  default     = ""
}

variable "evaluate_target_health" {
  description = "evaluate_target_health"
  default     = false
}

variable "type" {
  description = "type"
  default     = "A"
}
