resource "hcloud_ssh_key" "user_ssh_keys" {
  for_each = {
    for user in var.users : user.name => user
  }

  name       = "${var.server_name}-${var.server_location}-ssh-key-${each.value.name}"
  public_key = each.value.ssh_key
  labels = {
    managed    = "true"
    managed_by = each.value.name
    user_type  = "terraform_managed"
  }
}
