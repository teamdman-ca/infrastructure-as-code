#!/usr/bin/pwsh
kubectl create ns nginx-ingress
kubectl kustomize --enable-helm | kubectl apply -f -

# helm install ingress-nginx ingress-nginx/ingress-nginx `
#     --namespace ingress-basic `
#     --create-namespace `
#     --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz