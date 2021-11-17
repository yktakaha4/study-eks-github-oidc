resource "aws_iam_policy_attachment" "github_actions_readonly_policy" {
  name = "github-actions-readonly"
  roles = [
    aws_iam_role.github_actions_readonly_role.name,
  ]

  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
