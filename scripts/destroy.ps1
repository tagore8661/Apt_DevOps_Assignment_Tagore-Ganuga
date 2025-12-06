# PowerShell destroy helper
Set-Location -Path (Join-Path $PSScriptRoot "..\terraform")
terraform destroy -auto-approve
Write-Host "Terraform destroy finished."
