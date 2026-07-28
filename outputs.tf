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
  description = "Example SSH command for the first private instance via NAT."
  value       = "ssh -J ${var.nat_instance_ssh_user}@${aws_eip.nat.public_ip} ${var.private_instance_ssh_user}@${aws_instance.private[0].private_ip}"
}

output "scp_example" {
  description = "Example SCP command for copying a file to the first private instance via NAT."
  value       = "scp -J ${var.nat_instance_ssh_user}@${aws_eip.nat.public_ip} ./local-file ${var.private_instance_ssh_user}@${aws_instance.private[0].private_ip}:/tmp/"
}
