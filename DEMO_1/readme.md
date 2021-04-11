# Native Deployments

**Using K8S Deployments and Revisions**

## Run Deployment

```sh
kubectl apply -f deploy.yaml
kubectl expose deployment nginx --port 80

```

## Test Deployment

```sh

kubectl port-forward svc/nginx 8080:80

for ((i=1;i<=1000;i++)); do sleep 1 |  curl --header "Connection: keep-alive" "http://localhost:8080/info"; done | grep nginx/1.

```

## Update Version

```sh
kubectl set image deployment nginx nginx=nginx:1.17.1
```

## Test Deployment after version changed

```sh

kubectl port-forward svc/nginx 8080:80

for ((i=1;i<=1000;i++)); do sleep 1 |  curl --header "Connection: keep-alive" "http://localhost:8080/info"; done | grep nginx/1.

```

### Browse Revisions

```sh
kubectl rollout history deployment nginx

kubectl rollout undo deployment nginx --to-revision 1
```

## Test Deployment after version rolled back

```sh

kubectl port-forward svc/nginx 8080:80

for ((i=1;i<=1000;i++)); do sleep 1 |  curl --header "Connection: keep-alive" "http://localhost:5000/info"; done | grep nginx/1.

```

[Back](../readme.md)
