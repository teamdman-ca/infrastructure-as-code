#!/usr/bin/pwsh

kubectl kustomize --enable-helm | kubectl delete -f -
