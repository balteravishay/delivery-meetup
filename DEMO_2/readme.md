# Blue/Green Deployment

**Using Helm to achieve zero downtime B/G deployment**

## Prepare Prod as Blue

```sh
helm install api ./charts/api --set productionSlot=blue,blue.enabled=true,repository.image=nginx,blue.tag=1.16.1

```

## Test Production is Blue

```sh
kubectl port-forward svc/api-svc-prod  8080:80

for ((i=1;i<=1000;i++)); do sleep 1 |  curl --header "Connection: keep-alive" "http://localhost:8080/info"; done | grep nginx/1.

```

## Prepare Staging as Green

```sh
helm upgrade api ./charts/api  --reuse-values --set green.enabled=true,green.tag=1.17.1

```

## Test Staging is Green

```sh
kubectl port-forward svc/api-svc-stage  8080:80

for ((i=1;i<=1000;i++)); do sleep 1 |  curl --header "Connection: keep-alive" "http://localhost:8080/info"; done | grep nginx/1.
```

## Swap Production to Green

```sh
helm upgrade api ./charts/api  --reuse-values --set productionSlot=green

```

## Test Production is Green

```sh
kubectl port-forward svc/api-svc-prod  8080:80

for ((i=1;i<=1000;i++)); do sleep 1 |  curl --header "Connection: keep-alive" "http://localhost:8080/info"; done | grep nginx/1.
```

## Delete Blue

```sh
helm upgrade api ./charts/api  --reuse-values --set blue.enabled=false  

```

[Back](../readme.md)
