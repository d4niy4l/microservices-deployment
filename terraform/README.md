# Terraform AWS Infrastructure

This Terraform setup provisions a baseline AWS environment for running your Kubernetes node for the microservice backend.

## What it creates

- VPC
- Public subnet (for EC2 Kubernetes node)
- Private subnet (for db/internal workloads)
- Internet Gateway
- Public and private route tables with subnet associations
- Security group rules for SSH, HTTP, HTTPS, Kubernetes API, and ArgoCD UI
- One EC2 instance (`t3.medium` by default) with public IP

## Files

- `versions.tf`: Terraform and provider version constraints
- `providers.tf`: AWS provider
- `variables.tf`: Input variables
- `networking.tf`: VPC, subnets, IGW, route tables
- `security_groups.tf`: Ingress/egress firewall rules
- `compute.tf`: EC2 instance
- `outputs.tf`: Useful output values
- `terraform.tfvars.example`: Example variable values

## Usage

1. Initialize:

```bash
terraform init
```

2. Create your variables file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

3. Review and edit `terraform.tfvars`, especially:

- `ami_id`
- `availability_zone`
- `ssh_key_name`
- `ssh_ingress_cidr`
- `kubernetes_api_ingress_cidr`
- `argocd_ingress_cidr`

4. Validate and plan:

```bash
terraform fmt
terraform validate
terraform plan
```

5. Apply:

```bash
terraform apply
```

After apply, Terraform prints `ec2_public_ip` in outputs.
