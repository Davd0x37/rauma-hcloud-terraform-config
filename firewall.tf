# List of source IPs (incoming traffic) for the firewall
variable "firewall_source_ips" {
  type        = list(string)
  description = "List of source IPs for the firewall"
}

resource "hcloud_firewall" "server_s1_firewall" {
  name = "${var.server_name}-firewall"

  # SSH Rules
  rule {
    protocol   = "tcp"                   # Firewall rule for TCP
    direction  = "in"                    # Incoming traffic
    port       = var.ssh_port            # SSH port
    source_ips = var.firewall_source_ips # Allowed IPs for incoming traffic
  }

  # Port 80 Rules
  rule {
    protocol   = "tcp"                   # Firewall rule for TCP
    direction  = "in"                    # Incoming traffic
    port       = 80                      # For most web servers
    source_ips = var.firewall_source_ips # Allowed IPs for incoming traffic
  }

  # Port 443 Rules
  rule {
    protocol   = "tcp"                   # Firewall rule for TCP
    direction  = "in"                    # Incoming traffic
    port       = 443                     # For most web servers with SSL
    source_ips = var.firewall_source_ips # Allowed IPs for incoming traffic
  }
}
