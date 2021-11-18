output "cluster_name" {
  description = "Cluster name of EKS."
  value       = var.resource_prefix
}

output "role_to_assume" {
  description = "IAM Role to assume."
  value       = aws_iam_role.github_actions.arn
}
