# PowerShell deploy helper
Set-Location -Path (Join-Path $PSScriptRoot "..\terraform")
terraform init
terraform apply -auto-approve
Write-Host "Terraform apply finished."
