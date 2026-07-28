data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "ubuntu_24" {
  count = var.private_instance_ami == null ? 1 : 0

  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "amazon_linux_2023" {
  count = var.nat_instance_ami == null ? 1 : 0

  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  availability_zone = coalesce(var.availability_zone, data.aws_availability_zones.available.names[0])

  private_instance_ami_id = coalesce(var.private_instance_ami, try(data.aws_ami.ubuntu_24[0].id, null))
  nat_instance_ami_id     = coalesce(var.nat_instance_ami, try(data.aws_ami.amazon_linux_2023[0].id, null))

  common_tags = merge(
    var.tags,
    {
      Module = "airgap"
    }
  )

  nat_user_data = <<-EOF
    #!/bin/bash
    set -euxo pipefail

    sysctl -w net.ipv4.ip_forward=1
    grep -q '^net.ipv4.ip_forward' /etc/sysctl.conf || echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf

    PRIMARY_IF=$(ip -o -4 route show to default | awk '{print $$5}')
    iptables -t nat -C POSTROUTING -o "$PRIMARY_IF" -j MASQUERADE 2>/dev/null || \
      iptables -t nat -A POSTROUTING -o "$PRIMARY_IF" -j MASQUERADE
  EOF
}
