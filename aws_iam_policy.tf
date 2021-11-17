resource "aws_iam_policy" "albc" {
  name   = "${var.resource_prefix}-AWSLoadBalancerControllerIAMPolicy"
  policy = data.http.albc_iam_policy_json.body
}
