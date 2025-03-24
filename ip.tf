# Server creation with one linked primary ip (ipv4)
resource "hcloud_primary_ip" "server_s1_primary_ipv4" {
  name          = "${var.base_name}-${var.base_location}-ipv4"
  datacenter    = var.datacenter_helsinki
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = false
  labels = {
    managed    = "true"
    managed_by = var.user_name_admin
  }
}

# Server creation with one linked primary ip (ipv6)
resource "hcloud_primary_ip" "server_s1_primary_ipv6" {
  name          = "${var.base_name}-${var.base_location}-ipv6"
  datacenter    = var.datacenter_helsinki
  type          = "ipv6"
  assignee_type = "server"
  auto_delete   = false
  labels = {
    managed    = "true"
    managed_by = var.user_name_admin
  }
}
