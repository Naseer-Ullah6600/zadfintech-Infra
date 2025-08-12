# ZadFintech Infrastructure

This repository contains the Infrastructure as Code (IaC) implementation for ZadFintech using Terraform. The infrastructure is organized into two main components: Management and Resources.

## Repository Structure

```
├── Management/               # AWS Organizations and Account Management
│   ├── modules/
│   │   ├── accounts/        # AWS Account creation and management
│   │   ├── organizationUnit/# AWS Organization Units configuration
│   │   └── sso/            # AWS SSO (IAM Identity Center) setup
│   └── policies/
│       ├── scp/            # Service Control Policies
│       └── tag/            # Tagging Policies
└── Resources/               # AWS Resource Management
    └── modules/
        ├── eks/            # Amazon EKS cluster configuration
        └── elasticache-redis/ # Amazon ElastiCache for Redis setup
```

## Features

### Management Layer
- **AWS Organizations Management**
  - Organization Units (OU) structure
  - Multi-account setup and management
  - Service Control Policies (SCPs) for governance
  - Tag policies for consistent resource tagging

- **AWS SSO (IAM Identity Center)**
  - Centralized access management
  - Pre-configured permission sets (Administrator, PowerUser, ReadOnly)
  - Group-based access control
  - Multi-account access management

### Resource Layer
- **Amazon EKS (Kubernetes)**
  - Managed node groups
  - Auto-scaling configuration
  - Multiple add-ons:
    - VPC CNI
    - CoreDNS
    - EBS CSI Driver
    - EFS CSI Driver
    - Pod Identity Agent
    - Cert Manager

- **Amazon ElastiCache for Redis**
  - Replication group management
  - Encryption configuration
  - Auto failover support
  - Multi-AZ deployment options

## Security Features

- Enforced encryption for S3 buckets
- MFA deletion requirement
- Region restrictions
- VPC peering controls
- Root account access restrictions
- Privilege escalation prevention
- Security services protection

## Prerequisites

- AWS CLI configured
- Terraform >= 1.0
- Access to AWS Organizations management account
- S3 bucket for Terraform state storage

## Getting Started

1. Configure AWS credentials:
```bash
aws configure
```

2. Initialize Terraform:
```bash
cd Management
terraform init
```

3. Plan and apply Management layer:
```bash
terraform plan
terraform apply
```

4. Initialize and apply Resources layer:
```bash
cd ../Resources
terraform init
terraform plan
terraform apply
```

## State Management

- Management state stored in: `s3://canbolatter-terraform-state/management/terraform.tfstate`
- Resources state stored in: `s3://canbolatter-infra-state/dev/terraform.tfstate`

## Available Environments

- Development/Staging
- Production (configured)
- Security/Audit (configured)

## Contributing

1. Create a new branch
2. Make your changes
3. Submit a pull request

## Security

Please report security issues to the maintainers directly.

## License

Proprietary - All rights reserved