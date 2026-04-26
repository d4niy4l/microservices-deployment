# Ansible Single-Node Kubernetes Setup

This folder contains Ansible automation for a single EC2 node provisioned by Terraform.

## Inventory

Use either:

- static inventory: `inventory/hosts.ini`
- generated inventory from Terraform output: `inventory/update_inventory_from_terraform.sh`

Example:

```bash
cd ansible
./inventory/update_inventory_from_terraform.sh ~/.ssh/your-key.pem ubuntu
```

## Install Ansible collection

```bash
cd ansible
ansible-galaxy collection install -r requirements.yml
```

## Run playbooks

Run all steps:

```bash
cd ansible
ansible-playbook playbooks/site.yml
```

Run individually:

```bash
ansible-playbook playbooks/dependencies.yml
ansible-playbook playbooks/cluster.yml
ansible-playbook playbooks/argocd.yml
```

## What gets installed

- Docker + containerd + networking utilities
- MicroK8s (single node)
- ArgoCD in `argocd` namespace

After ArgoCD install, playbook output includes:

- URL: `https://<ec2_public_ip>`
- username: `admin`
- initial password
