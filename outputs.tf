output "key_pair_name" {
  description = "EC2 key pair name attached to the instances."
  value       = local.key_name
}

output "private_key_pem" {
  description = "Private key PEM for the module-created key pair. Null when an existing key_name was provided."
  value       = try(tls_private_key.ssh[0].private_key_pem, null)
  sensitive   = true
}

output "private_key_save_command" {
  description = "Command to save the generated private key to a local PEM file."
  value = var.key_name == null ? "terraform output -raw private_key_pem > ${local.key_file_name} && chmod 400 ${local.key_file_name}" : null
}

output "vpc_id" {
  description = "ID of the created VPC."
  value       = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "ID of the public subnet."
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID of the private subnet."
  value       = aws_subnet.private.id
}

output "availability_zone" {
  description = "Availability zone used by the subnets."
  value       = local.availability_zone
}

output "nat_instance_id" {
  description = "ID of the NAT instance."
  value       = aws_instance.nat.id
}

output "nat_public_ip" {
  description = "Elastic IP address of the NAT instance."
  value       = aws_eip.nat.public_ip
}

output "nat_private_ip" {
  description = "Private IP address of the NAT instance."
  value       = aws_instance.nat.private_ip
}

output "private_instance_ids" {
  description = "IDs of the private EC2 instances."
  value       = aws_instance.private[*].id
}

output "private_instance_private_ips" {
  description = "Private IP addresses of the private EC2 instances."
  value       = aws_instance.private[*].private_ip
}

output "ssh_proxy_command" {
  description = "SSH ProxyJump option for connecting to a private instance through the NAT instance."
  value       = "-J ${var.nat_instance_ssh_user}@${aws_eip.nat.public_ip}"
}

output "ssh_example" {
  description = "Example SSH command for the first private instance via ProxyJump (-J)."
  value       = var.key_name == null ? "ssh -i ${local.key_file_name} -J ${var.nat_instance_ssh_user}@${aws_eip.nat.public_ip} ${var.private_instance_ssh_user}@${aws_instance.private[0].private_ip}" : "ssh -J ${var.nat_instance_ssh_user}@${aws_eip.nat.public_ip} ${var.private_instance_ssh_user}@${aws_instance.private[0].private_ip}"
}

output "ssh_via_nat_example" {
  description = "Example commands for manual hop-by-hop SSH through the NAT instance."
  value = local.deploy_ssh_key_to_nat ? join("\n", [
    "ssh -i ${local.key_file_name} ${var.nat_instance_ssh_user}@${aws_eip.nat.public_ip}",
    "ssh private-1",
  ]) : "Enable deploy_ssh_private_key_to_nat and provide ssh_private_key_pem when using an existing key_name."
}

output "scp_via_nat_example" {
  description = "Example SCP command run from the NAT instance to a private host."
  value       = local.deploy_ssh_key_to_nat ? "scp ./local-file private-1:/tmp/" : null
}

output "scp_example" {
  description = "Example SCP command for copying a file to the first private instance via NAT."
  value       = var.key_name == null ? "scp -i ${local.key_file_name} -J ${var.nat_instance_ssh_user}@${aws_eip.nat.public_ip} ./local-file ${var.private_instance_ssh_user}@${aws_instance.private[0].private_ip}:/tmp/" : "scp -J ${var.nat_instance_ssh_user}@${aws_eip.nat.public_ip} ./local-file ${var.private_instance_ssh_user}@${aws_instance.private[0].private_ip}:/tmp/"
}
