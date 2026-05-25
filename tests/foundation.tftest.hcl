run "foundation_outputs_shared_conventions" {
  command = plan

  variables {
    project = "platform-foundation"
    env     = "stage"
    region  = "us-west-2"
  }

  assert {
    condition     = output.naming_prefix == "platform-foundation-stage"
    error_message = "foundation should expose a stable project-environment naming prefix."
  }

  assert {
    condition     = output.common_tags["project"] == "platform-foundation"
    error_message = "common tags should include the project."
  }

  assert {
    condition     = output.common_tags["environment"] == "stage"
    error_message = "common tags should include the environment."
  }

  assert {
    condition     = output.common_tags["managed_by"] == "terraform"
    error_message = "common tags should identify Terraform ownership."
  }
}

run "invalid_environment_is_rejected" {
  command = plan

  variables {
    project = "platform-foundation"
    env     = "qa"
    region  = "us-west-2"
  }

  expect_failures = [
    var.env,
  ]
}
