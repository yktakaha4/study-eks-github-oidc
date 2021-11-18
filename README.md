# study-eks-gitops

## Prerequirements

いずれも、ローカルからのインフラのデプロイのために使用します

- terraform
- Administrator の AWS 権限

## Usage

```
$ cp -p .envrc.sample .envrc
$ direnv allow

# variable.tf で定義されている github_repository_name を、ご自身のリポジトリ向けに修正してください

# EKSの作成
$ terraform init
$ terraform apply

# 実行後に表示される以下の値を、GitHubのSettings -> Secretsから CLUSTER_NAME, ROLE_TO_ASSUME の名前で設定してください
$ terraform output
cluster_name = "study-eks-gitops"
role_to_assume = "arn:aws:iam::1234567890:role/study-eks-gitops-github-actions"
```

## GitHub Actions

Usage が完了すると、以下が実施できます

- PR 作成時に `sock-shop.yml` の内容を `kubectl diff` した結果をコメント
- Actions タブより、任意のブランチの内容で稼働環境に `sock-shop.yml` をデプロイする
