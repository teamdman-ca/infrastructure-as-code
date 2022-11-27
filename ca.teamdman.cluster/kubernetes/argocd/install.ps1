#!/usr/bin/pwsh
kubectl create ns argocd
kubectl apply -k .

$pw = kubectl get secret -n argocd argocd-initial-admin-secret -o json | ConvertFrom-Json
$pw = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($pw.data.password))
Write-Host "ArgoCD admin password is `"${pw}`""

Write-Host "Waiting for certificate request to be approved"