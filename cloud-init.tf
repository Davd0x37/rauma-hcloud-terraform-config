locals {
  cloud_init_config = templatefile(
    "cloud-init.yaml",
    {
      user_admin_name        = var.user_admin_name
      user_admin_ssh_key     = var.user_admin_ssh_key
      user_mantainer_name    = var.user_mantainer_name
      user_mantainer_ssh_key = var.user_mantainer_ssh_key
      ssh_port               = var.ssh_port
      user_admin_password    = var.user_admin_password
    }
  )
}
