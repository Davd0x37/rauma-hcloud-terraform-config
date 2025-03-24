locals {
  cloud_init_config = templatefile(
    "cloud-init.yaml",
    {
      user_name_admin     = var.user_name_admin
      ssh_key_admin       = var.ssh_key_admin
      user_name_mantainer = var.user_name_mantainer
      ssh_key_mantainer   = var.ssh_key_mantainer
      ssh_port            = var.ssh_port
      user_name_admin     = var.user_name_admin
      user_name_mantainer = var.user_name_mantainer
      ssh_port            = var.ssh_port
    }
  )
}
