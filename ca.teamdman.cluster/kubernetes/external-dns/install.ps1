#!/usr/bin/pwsh

kubectl create ns external-dns-teamdman
# this will automatically create the charts/ directory
kubectl kustomize --enable-helm | kubectl apply -f -