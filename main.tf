module "foundation" {
  source  = "./modules/foundation"
  project = var.project
  env     = var.env
  tags = {
    owner = "platform"
    env   = var.env
  }
}

output "naming_prefix" {
  value = module.foundation.naming_prefix
}

output "common_tags" {
  value = module.foundation.common_tags
}
