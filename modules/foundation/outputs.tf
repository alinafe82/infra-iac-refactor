output "naming_prefix" {
  value = "${var.project}-${var.env}"
}

output "common_tags" {
  value = local.common_tags
}
