kubectl kustomize --enable-helm | kubectl delete -f -
kubectl delete ns ingress-nginx