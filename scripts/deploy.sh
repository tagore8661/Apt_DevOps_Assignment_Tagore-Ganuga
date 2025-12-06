#!/usr/bin/env bash
set -euo pipefail

# Simple helper to run terraform deploy
cd "$(dirname "$0")/.." || exit 1
cd terraform || exit 1
terraform init
terraform apply -auto-approve

echo "Terraform apply finished. Check outputs for ALB DNS." 
