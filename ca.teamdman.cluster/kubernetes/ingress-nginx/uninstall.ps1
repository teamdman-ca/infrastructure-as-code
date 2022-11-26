kubectl kustomize --enable-helm | kubectl delete -f -
kubectl delete ns nginx-ingress

# helm --namespace ingress-basic delete ingress-nginx
# kubectl delete namespace ingress-basic