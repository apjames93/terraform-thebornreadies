variable "domain_name" {
  description = "domain_name"
}

variable "origin_id" {
  description = "origin_id"
}

variable "origin_access_identity" {
  description = "origin_access_identity"
}

variable "iam_certificate_id" {
  description = "iam_certificate_id"
}

variable "environment_tag" {
  description = "environment_tag"
}

variable "aliases" {
  type = "list"
}
