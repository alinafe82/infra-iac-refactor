variable "region" {
  type    = string
  default = "us-west-2"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]+$", var.region))
    error_message = "region must look like an AWS region, for example us-west-2."
  }
}

variable "project" {
  type    = string
  default = "platform-foundation"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,48}$", var.project))
    error_message = "project must be 3-49 lowercase letters, numbers, or hyphens and start with a letter."
  }
}

variable "env" {
  type    = string
  default = "dev"

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
