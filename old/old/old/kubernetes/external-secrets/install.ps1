#!/usr/bin/pwsh

kubectl create ns external-secrets
kubectl kustomize --enable-helm | kubectl apply -f -