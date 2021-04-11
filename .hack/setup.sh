export GHUSER="avbalter@microsoft.com"

kubectl create namespace ingress-nginx
kubectl create namespace flux

helm repo add flagger https://flagger.app

helm upgrade -i nginx-ingress stable/nginx-ingress \
--namespace ingress-nginx \
--set controller.stats.enabled=true \
--set controller.metrics.enabled=true \
--set controller.podAnnotations."prometheus\.io/scrape"=true \
--set controller.podAnnotations."prometheus\.io/port"=10254

helm upgrade -i flagger flagger/flagger \
--namespace ingress-nginx \
--set prometheus.install=true \
--set meshProvider=nginx

kubectl create ns flux

fluxctl install \
--git-user=${GHUSER} \
--git-email=${GHUSER}@users.noreply.github.com \
--git-url=abalterteam@vs-ssh.visualstudio.com:v3/abalterteam/delivery-meetup/delivery-meetup \
--git-path=DEMO_3/charts \
--namespace=flux | kubectl apply -f -

	
kubectl -n flux rollout status deployment/flux

export FLUX_SSH="$(fluxctl identity --k8s-fwd-ns flux)"
echo $FLUX_SSH
