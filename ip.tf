# Server creation with one linked primary ip (ipv4)
resource "hcloud_primary_ip" "server_s1_primary_ipv4" {
  name          = "${var.server_name}-${var.server_location}-ipv4"
  datacenter    = var.datacenter_id
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = false
  labels = {
    managed    = "true"
    managed_by = var.user_admin_name
  }
}

# Server creation with one linked primary ip (ipv6)
resource "hcloud_primary_ip" "server_s1_primary_ipv6" {
  name          = "${var.server_name}-${var.server_location}-ipv6"
  datacenter    = var.datacenter_id
  type          = "ipv6"
  assignee_type = "server"
  auto_delete   = false
  labels = {
    managed    = "true"
    managed_by = var.user_admin_name
  }
}
