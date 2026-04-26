resource "aws_eip" "k8s_node" {
  instance = aws_instance.k8s_node.id
  domain    = "vpc"

  tags = {
    Name = "${var.project_name}-k8s-node-eip"
  }
}

resource "aws_instance" "k8s_node" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.k8s_node.id]
  key_name                    = var.ssh_key_name
  associate_public_ip_address = false

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    delete_on_termination = true
    encrypted             = true
  }

  tags = {
    Name = "${var.project_name}-k8s-node"
    Role = "kubernetes"
  }
}
