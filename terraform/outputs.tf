output "vpc_id" {
  description = "ID of the created VPC."
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet."
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID of the private subnet."
  value       = aws_subnet.private.id
}

output "security_group_id" {
  description = "ID of the EC2 node security group."
  value       = aws_security_group.k8s_node.id
}

output "ec2_instance_id" {
  description = "ID of the Kubernetes EC2 node."
  value       = aws_instance.k8s_node.id
}

output "ec2_public_ip" {
  description = "Elastic IP of the Kubernetes EC2 node."
  value       = aws_eip.k8s_node.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS of the Kubernetes EC2 node (via Elastic IP)."
  value       = aws_eip.k8s_node.public_dns
}

output "selected_ami" {
  description = "AMI used for the EC2 node."
  value       = aws_instance.k8s_node.ami
}
