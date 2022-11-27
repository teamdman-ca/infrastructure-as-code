#!/usr/bin/pwsh

kubectl kustomize --enable-helm | kubectl delete -f -
# helm uninstall --namespace kube-system blob-csi-driver