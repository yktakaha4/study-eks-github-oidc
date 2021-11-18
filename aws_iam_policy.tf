resource "aws_iam_policy" "albc" {
  name   = "${var.resource_prefix}-AWSLoadBalancerControllerIAMPolicy"
  policy = data.http.albc_iam_policy_json.body
}

resource "aws_iam_policy" "github_actions" {
  name = "${var.resource_prefix}-github-actions"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "eks:DescribeCluster"
      Resource = module.eks.cluster_arn
    }]
  })
}
