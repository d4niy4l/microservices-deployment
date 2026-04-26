variable "aws_region" {
  description = "AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project identifier used in resource names and tags."
  type        = string
  default     = "purely"
}

variable "availability_zone" {
  description = "Availability zone for both subnets, provided via tfvars."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet (db/internal workloads)."
  type        = string
  default     = "10.0.2.0/24"
}

variable "instance_type" {
  description = "EC2 instance type for Kubernetes node."
  type        = string
  default     = "t3.medium"
}

variable "ssh_key_name" {
  description = "Existing EC2 key pair name for SSH access."
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance, provided via tfvars."
  type        = string
}

variable "root_volume_size" {
  description = "Root EBS volume size in GiB."
  type        = number
  default     = 30
}

variable "ssh_ingress_cidr" {
  description = "CIDR allowed to access SSH (port 22). Restrict this in production."
  type        = string
  default     = "0.0.0.0/0"
}

variable "web_ingress_cidr" {
  description = "CIDR allowed to access HTTP/HTTPS."
  type        = string
  default     = "0.0.0.0/0"
}

variable "kubernetes_api_port" {
  description = "Port exposed for Kubernetes API."
  type        = number
  default     = 6443
}

variable "kubernetes_api_ingress_cidr" {
  description = "CIDR allowed to access Kubernetes API port."
  type        = string
  default     = "0.0.0.0/0"
}

variable "argocd_ui_port" {
  description = "Port exposed for ArgoCD UI."
  type        = number
  default     = 8080
}

variable "argocd_ingress_cidr" {
  description = "CIDR allowed to access ArgoCD UI port."
  type        = string
  default     = "0.0.0.0/0"
}
