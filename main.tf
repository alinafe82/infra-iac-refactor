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
