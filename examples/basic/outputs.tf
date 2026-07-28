output "vpc_id" {
  value = module.airgap.vpc_id
}

output "nat_public_ip" {
  value = module.airgap.nat_public_ip
}

output "private_instance_private_ips" {
  value = module.airgap.private_instance_private_ips
}

output "ssh_example" {
  value = module.airgap.ssh_example
}

output "scp_example" {
  value = module.airgap.scp_example
}
