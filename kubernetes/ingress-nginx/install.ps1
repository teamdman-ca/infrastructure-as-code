#!/usr/bin/pwsh
kubectl create ns ingress-nginx
kubectl kustomize --enable-helm | kubectl apply -f -