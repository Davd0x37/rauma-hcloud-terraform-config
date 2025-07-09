resource "hcloud_server" "server_s1_helsinki" {
  name         = "${var.server_name}-${var.server_location}" # Server name
  image        = var.system_image_name                       # Base image
  server_type  = var.server_type                             # Server type - default CAX11 with ARM CPU
  datacenter   = var.datacenter_id                           # Datacenter location - default Helsinki
  user_data    = local.cloud_init_config                     # Located in cloud-init.tf
  firewall_ids = [hcloud_firewall.server_s1_firewall.id]     # Firewall ID list
  ssh_keys = [
    hcloud_ssh_key.server_s1_user_admin_ssh_key.id,
    hcloud_ssh_key.server_s1_ssh_key_user.id
  ]

  public_net {
    ipv4_enabled = true
    ipv4         = hcloud_primary_ip.server_s1_primary_ipv4.id
    ipv6_enabled = true
    ipv6         = hcloud_primary_ip.server_s1_primary_ipv6.id
  }
}
