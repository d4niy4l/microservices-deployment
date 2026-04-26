resource "aws_security_group" "k8s_node" {
  name        = "${var.project_name}-k8s-node-sg"
  description = "Security group for single EC2 node running Kubernetes"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_ingress_cidr]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.web_ingress_cidr]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.web_ingress_cidr]
  }

  ingress {
    description = "Kubernetes API"
    from_port   = var.kubernetes_api_port
    to_port     = var.kubernetes_api_port
    protocol    = "tcp"
    cidr_blocks = [var.kubernetes_api_ingress_cidr]
  }

  ingress {
    description = "ArgoCD UI"
    from_port   = var.argocd_ui_port
    to_port     = var.argocd_ui_port
    protocol    = "tcp"
    cidr_blocks = [var.argocd_ingress_cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-k8s-node-sg"
  }
}
