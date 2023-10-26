$subs = az account list | ConvertFrom-Json

$active = $null;
$desired = $null;
$desired_name = "AAFC VSE Benefit"

foreach($sub in $subs) {
    if ($sub.isDefault) {
        $active = $sub
    }
    if ($sub.name -eq $desired_name) {
        $desired = $sub
    }
}

Write-Host "Currently have $($active.name) selected"

if ($active.id -ne $desired.id) {
    Write-Host "Switching subscription to $($desired.name)"
    az account set --subscription $desired.id
} else {
    Write-Host "Correct subscription already selected"
}

Write-Host "Currently on subscription $(az account show --query "name" -o tsv)"

Write-Host "Beginning terraform apply" -ForegroundColor Cyan
terraform apply