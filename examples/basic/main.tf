module "airgap" {
  source = "../.."

  name_prefix               = var.name_prefix
  key_name                  = var.key_name
  ssh_allowed_cidr_blocks   = var.ssh_allowed_cidr_blocks
  private_instance_count    = var.private_instance_count
  private_instance_ami      = var.private_instance_ami
  private_instance_type     = var.private_instance_type
  nat_instance_ami          = var.nat_instance_ami
  nat_instance_type         = var.nat_instance_type
}
