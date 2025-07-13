resource "hcloud_server" "server_s1_helsinki" {
  name         = "${var.server_name}-${var.server_location}" # Server name
  image        = var.system_image_name                       # Base image
  server_type  = var.server_type                             # Server type - default CAX11 with ARM CPU
  datacenter   = var.datacenter_id                           # Datacenter location - default Helsinki
  firewall_ids = [hcloud_firewall.server_s1_firewall.id]     # Firewall ID list
  ssh_keys = [
    for ssh_key in hcloud_ssh_key.user_ssh_keys : ssh_key.id
  ]

  public_net {
    ipv4_enabled = true
    ipv4         = hcloud_primary_ip.server_s1_primary_ipv4.id
    ipv6_enabled = true
    ipv6         = hcloud_primary_ip.server_s1_primary_ipv6.id
  }
}

resource "local_file" "inventory" {
  content  = <<-EOT
all:
  hosts:
    ${hcloud_server.server_s1_helsinki.name}:
      ansible_host: ${hcloud_server.server_s1_helsinki.ipv4_address}
  EOT
  filename = "ansible/inventory.yml"
}

resource "local_file" "ansible_secret_vars" {
  content  = <<-EOT
---
# SSH Port
ssh_port: ${var.ssh_port}

# Users
users:
%{for user in var.users~}
  - name: ${user.name}
    groups: "${user.groups}"
    ssh_key: "${user.ssh_key}"
%{if user.password != null~}
    password: "${user.password}"
%{endif~}
%{if user.sudo_nopasswd == true~}
    sudo_nopasswd: true
%{endif~}
%{endfor~}

# Provisioning
tailscale_auth_key: "${var.tailscale_auth_key}"
  EOT
  filename = "ansible/secret-vars.yml"

  depends_on = [hcloud_server.server_s1_helsinki]
}

# Resource to run Ansible in the correct order
resource "null_resource" "ansible_provisioner" {
  # Restart when the server IP or playbook file changes
  triggers = {
    playbook_hash = filemd5("${path.module}/ansible/playbook.yml")
    server_ip     = hcloud_server.server_s1_helsinki.ipv4_address
  }

  # Explicit dependency on files required by Ansible
  depends_on = [
    local_file.inventory,
    local_file.ansible_secret_vars
  ]

  provisioner "local-exec" {
    # Wait 45 seconds to ensure the server is ready
    command     = "sleep 45 && ansible-playbook -i inventory.yml playbook.yml -v"
    working_dir = "${path.module}/ansible"
  }
}

resource "local_file" "ssh_config" {
  content  = <<-EOT
# This file is managed by Terraform. Do not edit manually.

# Static entry for the root user
Host ${var.server_name}-root
  HostName ${hcloud_server.server_s1_helsinki.ipv4_address}
  User root
  Port 22
  IdentityFile ${[for u in var.users : u.identity_file if u.use_identity_file_for_root][0]}

# Dynamic entries for other users
%{for user in var.users~}
Host ${var.server_name}-${user.name}
  HostName ${hcloud_server.server_s1_helsinki.ipv4_address}
  User ${user.name}
  Port ${var.ssh_port}
  IdentityFile ${user.identity_file}

%{endfor~}
EOT
  filename = pathexpand("~/.ssh/HCloudTerraform/config")
}
