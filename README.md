# DevOps Assignment: One-Click Deployment

A production-ready, one-click deployment solution that provisions a REST API server running on private EC2 instances behind an Application Load Balancer (ALB) with Auto Scaling Group (ASG).

## Architecture Overview

```
Internet
   ↓
Internet Gateway
   ↓
Application Load Balancer (Public Subnets)
   ↓
Target Group (Health Checks)
   ↓
Auto Scaling Group
   ↓
EC2 Instances (Private Subnets - No Public IPs)
   ↓
NAT Gateway → Internet Gateway (Egress Only)
```

## Infrastructure Components

- **VPC**: Custom VPC with CIDR block
- **Subnets**:
  - 2 Public subnets (for ALB and NAT Gateway)
  - 2 Private subnets (for EC2 instances)
- **Internet Gateway**: For public internet access
- **NAT Gateway**: For private subnet egress
- **Application Load Balancer**: Public-facing, HTTP/HTTPS listener
- **Target Group**: Health checks on `/health` endpoint
- **Auto Scaling Group**: Min 2, Max 4 instances
- **Launch Template**: EC2 instance configuration
- **Security Groups**:
  - ALB SG: Allows HTTP (80) and HTTPS (443) from internet
  - EC2 SG: Allows traffic only from ALB SG on port 8080
- **IAM Role**: EC2 instances with CloudWatch Logs and SSM permissions


### AWS Credentials Setup

**Option 1: AWS CLI Configure**
```bash
aws configure
```

**Option 2: Environment Variables**
```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

**Option 3: AWS Profile**
```bash
export AWS_PROFILE="your-profile-name"
```

### Verify AWS Access
```bash
aws sts get-caller-identity
```

## Project Structure

```
.
├── app/                    # REST API Application
│   ├── server.py           # Python API server
│   └── requirements.txt    # Requirements
├── screenshots/            # Documentation screenshots
│   ├──01-VPC-Setup.png
│   ├──02-Private-EC2-Instances.png
│   ├──03-Target-Group.png
│   ├──04-ALB.png
│   ├──05-Simple-Text-Response.png
│   ├──06-Health-Check.png
│   └──07-Destroy.png
├── scripts/                # Automation scripts
│   ├── deploy.sh           # Linux/macOS deployment
│   ├── deploy.ps1          # Windows PowerShell deployment
│   ├── destroy.sh          # Linux/macOS teardown
│   ├── destroy.ps1         # Windows PowerShell teardown
│   ├── test.sh             # Linux/macOS testing
│   └── test.ps1            # Windows PowerShell testing
├── terraform/              # Infrastructure as Code
│   ├── main.tf             # Main Terraform configuration
│   ├── variables.tf        # Input variables
│   ├── outputs.tf          # Output values
│   ├── provider.tf         # Provider Details
│   └── terraform.tfvars    # Variable values (optional)
├── .github/
└── README.md               # This file
```

## Quick Start

### Step 1: Clone Repository
```bash
git clone <repository-url>
cd <repository-name>
```

### Step 2: Deploy Infrastructure

**Linux/macOS:**
```bash
chmod +x scripts/*.sh
./scripts/deploy.sh
```

**Windows PowerShell:**
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\deploy.ps1
```

**Manual Terraform Deployment:**
```bash
cd terraform
terraform init
terraform plan
terraform apply -auto-approve
```

### Step 3: Get ALB DNS Name

After deployment completes, retrieve the ALB DNS:
```bash
cd terraform
terraform output alb_dns_name
```

Or find it in AWS Console: EC2 → Load Balancers → Select your ALB → DNS name

### Step 4: Test the API

**Wait 2-3 minutes for instances to be healthy**, then test:

**Using scripts (Linux/macOS):**
```bash
# Replace <ALB-DNS-NAME> with your actual ALB DNS
./scripts/test.sh
```

**Using scripts (Windows PowerShell):**
```powershell
# Replace <ALB-DNS-NAME> with your actual ALB DNS
.\scripts\test.ps1
```

**Manual Testing:**
```bash
# Replace <ALB-DNS-NAME> with your actual ALB DNS
curl http://<ALB-DNS-NAME>/
curl http://<ALB-DNS-NAME>/health
```

**Expected responses:**
- `GET /` → `Hello from private EC2`
- `GET /health` → `ok`

### Step 5: Teardown (Clean Up)

**IMPORTANT**: Always teardown to avoid AWS charges!

**Linux/macOS:**
```bash
./scripts/destroy.sh
```

**Windows PowerShell:**
```powershell
.\scripts\destroy.ps1
```

**Manual Terraform Destroy:**
```bash
cd terraform
terraform destroy -auto-approve
```