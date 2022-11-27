#!/usr/bin/pwsh

# something keeps adding the finalizers back and I don't know why
# for now we can just hard remove them before nuking the resources
kubectl patch app argocd -n argocd -p '{"metadata":{"finalizers":null}}' --type=merge
kubectl patch app app-of-apps -n argocd -p '{"metadata":{"finalizers":null}}' --type=merge
kubectl patch appproject core -n argocd -p '{"metadata":{"finalizers":null}}' --type=merge

kubectl delete -k .
