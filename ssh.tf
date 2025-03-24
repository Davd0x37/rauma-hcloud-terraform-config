# Custom ssh port - used in cloud-init.tf
variable "ssh_port" {
  type        = number
  description = "ssh port - change to custom in env.tfvars"
  default     = 22
}

# Admin ssh key - used in cloud-init.tf and while creating server
variable "ssh_key_admin" {
  type        = string
  description = "admin ssh key - change to custom in env.tfvars"
}

# Mantainer ssh key - same as admin key
variable "ssh_key_mantainer" {
  type        = string
  description = "mantainer ssh key - change to custom in env.tfvars"
}

# Main ssh key for admin
resource "hcloud_ssh_key" "server_s1_ssh_key_admin" {
  name       = "${var.base_name}-${var.base_location}-ssh-key-admin"
  public_key = var.ssh_key_admin
  labels = {
    managed    = "true"
    managed_by = var.user_name_admin
  }
}

# SSH key for user - it will be user with privileges to manage the server - coolify or other
resource "hcloud_ssh_key" "server_s1_ssh_key_user" {
  name       = "${var.base_name}-${var.base_location}-ssh-key-mantainer"
  public_key = var.ssh_key_mantainer
  labels = {
    managed    = "true"
    managed_by = var.user_name_mantainer
  }
}
