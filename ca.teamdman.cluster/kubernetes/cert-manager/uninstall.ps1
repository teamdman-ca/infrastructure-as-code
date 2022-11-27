#!/usr/bin/pwsh

kubectl kustomize --enable-helm | kubectl delete -f -

# helm --namespace cert-manager delete cert-manager
# kubectl delete namespace cert-manager
# # kubectl delete -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.yaml