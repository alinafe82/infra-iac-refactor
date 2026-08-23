module "foundation" {
  source  = "./modules/foundation"
  project = var.project
  env     = var.env
  tags = merge({ owner = "platform", env = var.env }, var.tags)
}

output "naming_prefix" {
  value = module.foundation.naming_prefix
}

output "common_tags" {
  value = module.foundation.common_tags
}
