#!/usr/bin/pwsh

kubectl create ns cert-manager
kubectl kustomize --enable-helm | kubectl apply -f -
Write-Host "Install complete, consider running verify.ps1" -ForegroundColor "Cyan"