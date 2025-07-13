# List of source IPs (incoming traffic) for the firewall
variable "firewall_source_ips" {
  type        = list(string)
  description = "List of source IPs for the firewall"
}

locals {
  public_source_ips = ["0.0.0.0/0", "::/0"]
}

resource "hcloud_firewall" "server_s1_firewall" {
  name = "${var.server_name}-firewall"

  # SSH Rules
  dynamic "rule" {
    for_each = toset([var.ssh_port, 22])
    content {
      protocol   = "tcp"
      direction  = "in"
      port       = rule.value
      source_ips = var.firewall_source_ips
    }
  }

  # Tailscale UDP port rule
  rule {
    protocol   = "udp"
    direction  = "in"
    port       = "41641"
    source_ips = local.public_source_ips
  }

  # Port 80 Rules
  rule {
    protocol   = "tcp" # Firewall rule for TCP
    direction  = "in"  # Incoming traffic
    port       = 80    # For most web servers
    source_ips = var.use_public_firewall_ips ? local.public_source_ips : var.firewall_source_ips
  }

  # Port 443 Rules
  rule {
    protocol   = "tcp" # Firewall rule for TCP
    direction  = "in"  # Incoming traffic
    port       = 443   # For most web servers with SSL
    source_ips = var.use_public_firewall_ips ? local.public_source_ips : var.firewall_source_ips
  }
}
