resource "aws_iam_policy_attachment" "github_actions" {
  name = "${var.resource_prefix}-github-actions"
  roles = [
    aws_iam_role.github_actions.name,
  ]

  policy_arn = aws_iam_policy.github_actions.arn
}
