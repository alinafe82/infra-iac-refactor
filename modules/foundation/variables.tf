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

  validation {
    condition = alltrue([
      for key, value in var.tags : length(trimspace(key)) > 0 && length(trimspace(value)) > 0
    ])
    error_message = "tag keys and values must not be blank."
  }

  validation {
    condition = length(setintersection(
      toset(keys(var.tags)),
      toset(["project", "environment", "managed_by"])
    )) == 0
    error_message = "tags must not override project, environment, or managed_by."
  }
}
