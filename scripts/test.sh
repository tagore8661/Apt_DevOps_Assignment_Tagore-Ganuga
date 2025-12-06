#!/usr/bin/env bash

#ALB_DNS="${ALB_DNS:-asg-alb-369894940.us-east-1.elb.amazonaws.com}"
ALB_DNS="${ALB_DNS:-your-alb-dns-name}"
if [ "$ALB_DNS" = "your-alb-dns-name" ]; then
  echo "Set ALB_DNS environment variable or update this script with the ALB DNS name."
  exit 1
fi

curl -v "http://$ALB_DNS/health"
