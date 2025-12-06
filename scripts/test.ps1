# PowerShell test helper. Set $env:ALB_DNS or replace below
$alb = $env:ALB_DNS
if (-not $alb) {
    # fallback to your ALB DNS if env var not set
    #$alb = "asg-alb-369894940.us-east-1.elb.amazonaws.com"
    $alb = "your-alb-dns-name"
}

Write-Host "Testing ALB at $alb"
Invoke-RestMethod -Uri "http://$alb/health" -Method Get