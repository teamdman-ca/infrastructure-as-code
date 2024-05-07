#!/usr/bin/pwsh

kubectl kustomize --enable-helm | kubectl delete -f -
kubectl delete namespace cert-manager