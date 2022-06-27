helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager `
    --namespace "cert-manager" `
    --create-namespace `
    --version "v1.8.2" `
    -f "values.yaml"

# kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.yaml