#!/usr/bin/pwsh
helm upgrade "teamdman" . `
    --install `
    --namespace "teamdman" `
    --create-namespace 