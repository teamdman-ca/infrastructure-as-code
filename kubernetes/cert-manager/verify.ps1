# https://cert-manager.io/docs/installation/verify/
cmctl check api --wait=2m
kubectl get pods --namespace cert-manager;