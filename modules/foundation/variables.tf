variable "project" {
  type = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,48}$", var.project))
    error_message = "project must be 3-49 lowercase letters, numbers, or hyphens and start with a letter."
  }
}

variable "env" {
  type = string

  validation {
    condition     = contains(["dev", "stage", "prod"], var.env)
    error_message = "env must be one of dev, stage, or prod."
  }
}

variable "tags" {
  type    = map(string)
  default = {}
}
