locals {
  common_tags = merge(
    var.tags,
    {
      project     = var.project
      environment = var.env
      managed_by  = "terraform"
    }
  )
}
