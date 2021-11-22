# Terraform configuration

# This is to get the account ID of the current profile
data "aws_caller_identity" "current" {}

locals {
    account_id = data.aws_caller_identity.current.account_id
}

# output "account_id" {
#   value = local.account_id
# }

###
# Role with an assume role policy so it can be assumed within the account
###
data "aws_iam_policy_document" "modular_ci_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.account_id}:root"]
    }
  }
}

resource "aws_iam_role" "modular_ci" {
  name = "${var.ci_name}-ci"
  assume_role_policy = data.aws_iam_policy_document.modular_ci_assume_role_policy.json
}

###
# User, group, and membership
###
resource "aws_iam_user_group_membership" "modular_ci" {
  user = aws_iam_user.modular_ci.name

  groups = [
    aws_iam_group.modular_ci.name,
  ]
}

resource "aws_iam_user" "modular_ci" {
  name = "${var.ci_name}-ci"
}

resource "aws_iam_group" "modular_ci" {
  name = "${var.ci_name}-ci"
}

###
# Policy Document, Policy and Policy attachment
###
data "aws_iam_policy_document" "modular_ci" {
  statement {
    actions = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.ci_name}_ci"]
  }
}

resource "aws_iam_policy" "modular_ci" {
  name        = "${var.ci_name}-ci"
  description = "A policy for the modular kind to assume the modular-ci role"

  policy = data.aws_iam_policy_document.modular_ci.json
}

resource "aws_iam_policy_attachment" "modular_ci" {
  name       = "modular-ci"
  groups     = [aws_iam_group.modular_ci.name]
  policy_arn = aws_iam_policy.modular_ci.arn
}