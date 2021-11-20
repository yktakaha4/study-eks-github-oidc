variable "region" {
  default = "ap-northeast-1"
}

variable "resource_prefix" {
  default = "study-eks-github-oidc"
}

variable "vpc_cidr_first_and_second_octets" {
  default = "172.16"
}

variable "github_repository_name" {
  default = "yktakaha4/study-eks-github-oidc"
}
