resource "aws_iam_policy_attachment" "github_actions_readonly_policy" {
  name = "${var.resource_prefix}-github-actions-readonly"
  roles = [
    aws_iam_role.github_actions_role.name,
  ]

  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
