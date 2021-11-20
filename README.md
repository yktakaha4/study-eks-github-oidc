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

# CIから変更しない固定のk8sオブジェクトを作成
$ aws eks update-kubeconfig --name study-eks-gitops
$ kubectl apply -f ./manifests/system.yml
```

## GitHub Actions

Usage が完了すると、以下が実施できます

- PR 作成時に `sock-shop.yml` の内容を `kubectl diff` した結果をコメント
- Actions タブより、任意のブランチの内容で稼働環境に `sock-shop.yml` をデプロイできる

## サービスへ接続

ブラウザにて HTTP 接続すると、[sock-shop](https://microservices-demo.github.io/)が表示されます

```
# EKSへのアクセス権限を取得
$ aws eks update-kubeconfig --name study-eks-gitops

# ALBの確認
$ kubectl get ingress -n sock-shop
NAME        CLASS    HOSTS   ADDRESS                                                                    PORTS   AGE
sock-shop   <none>   *       k8s-sockshop-sockshop-xxxxxxxx-12345678.ap-northeast-1.elb.amazonaws.com   80      10m
```

## お片付け

ローカル環境から以下実施

```
# EKSへのアクセス権限を取得
$ aws eks update-kubeconfig --name study-eks-gitops

# クラスタの各種オブジェクト削除
# これを忘れてterraform destroyすると、ALBなどk8s経由で作成したリソースが消えないので注意
$ kubectl delete -f ./manifests/sock-shop.yml

# インフラ削除
$ terraform destroy
```
