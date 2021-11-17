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

  node_groups = {
    study-eks-gitops = {
      desired_capacity = 2
      max_capacity     = 2
      min_capacity     = 2

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
