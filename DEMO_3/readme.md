# Automated Canary with GitOps

**Using Flagger and Flux to automate gitops**

## Deploy application

``` sh
kubectl apply -f charts/deploy.yaml
kubectl apply -f charts/hpa.yaml
kubectl apply -f charts/ingress.yaml

```

## Deploy Canary

```sh
kubectl apply -f charts/canary.yaml

kubectl describe canary/meetup
```

## Set new version

```sh
kubectl set image deployment/meetup meetup=nginx:1.17.1

kubectl describe canary/meetup
```

## Test Version

```sh

kubectl port-forward svc/meetup-primary 8080:80

for ((i=1;i<=1000;i++)); do  curl --header "Connection: keep-alive" "http://localhost:8080/info"; done | grep nginx/1.17

```

## Connect Flux to repo

```sh
echo $FLUX_SSH
```

- GitHub users - follow this [link](https://help.github.com/en/enterprise/2.15/user/articles/adding-a-new-ssh-key-to-your-github-account)
- Azure Repos users - follow this [link](https://docs.microsoft.com/en-us/azure/devops/repos/git/use-ssh-keys-to-authenticate?view=azure-devops&tabs=preview-page%2Ccurrent-page)

## change version

- Change version of nginx in the repo

``` sh
fluxctl sync --k8s-fwd-ns flux

k get canary --all-namespaces
```

[Back](../readme.md)
