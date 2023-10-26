# $pat = op read "op://Private/Github terraform access token/password"
$pat = gh auth token
Set-Content ".env" "github_token=$pat"
