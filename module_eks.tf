module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.0.0"

  cluster_name    = var.resource_prefix
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets

  tags = {
    Name = var.resource_prefix
  }

  vpc_id = module.vpc.vpc_id

  map_roles = [{
    rolearn  = aws_iam_role.github_actions.arn
    username = "github-actions"
    groups   = ["admin-group"]
  }]

  node_groups = {
    workers = {
      # Sock-shopの起動にIPが必要
      # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html#AvailableIpPerENI
      desired_capacity = 4
      min_capacity     = 4
      max_capacity     = 4

      instance_types = ["t3.small"]

      k8s_labels = {
        Name = var.resource_prefix
      }

      additional_tags = {
        Name = var.resource_prefix
      }
    }
  }

  write_kubeconfig = false
  enable_irsa      = true
}
