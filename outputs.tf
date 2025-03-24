# Preview cloud-init config
output "cloud_init" {
  value = "\n${local.cloud_init_config}\n"
}
