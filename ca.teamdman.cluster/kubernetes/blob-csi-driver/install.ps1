#!/usr/bin/pwsh

kubectl kustomize --enable-helm | kubectl apply -f -
# helm install blob-csi-driver blob-csi-driver/blob-csi-driver --set node.enableBlobfuseProxy=true --namespace kube-system --set cloud=AzureStackCloud