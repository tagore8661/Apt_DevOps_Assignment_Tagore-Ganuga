#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.." || exit 1
cd terraform || exit 1
terraform destroy -auto-approve

echo "Terraform destroy finished." 
