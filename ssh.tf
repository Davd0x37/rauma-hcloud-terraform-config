# Custom ssh port - used in cloud-init.tf
variable "ssh_port" {
  type        = number
  description = "ssh port - change to custom in env.tfvars"
  default     = 22
}

# Admin ssh key - used in cloud-init.tf and while creating server
variable "user_admin_ssh_key" {
  type        = string
  description = "admin ssh key - change to custom in env.tfvars"
}

# Mantainer ssh key - same as admin key
variable "user_mantainer_ssh_key" {
  type        = string
  description = "mantainer ssh key - change to custom in env.tfvars"
}

# Main ssh key for admin
resource "hcloud_ssh_key" "server_s1_user_admin_ssh_key" {
  name       = "${var.server_name}-${var.server_location}-ssh-key-admin"
  public_key = var.user_admin_ssh_key
  labels = {
    managed    = "true"
    managed_by = var.user_admin_name
  }
}

# SSH key for user - it will be user with privileges to manage the server - coolify or other
resource "hcloud_ssh_key" "server_s1_ssh_key_user" {
  name       = "${var.server_name}-${var.server_location}-ssh-key-mantainer"
  public_key = var.user_mantainer_ssh_key
  labels = {
    managed    = "true"
    managed_by = var.user_mantainer_name
  }
}
