# Description: Variables for the Hetzner Cloud provider

# HCLOUD token
variable "hcloud_token" {
  description = "Hetzner API token"
  sensitive   = true
  type        = string
}

# Server base name
variable "base_name" {
  type        = string
  description = "server base name"
}

# Server base location
variable "base_location" {
  type        = string
  description = "server base location - used only in naming"
  default     = "helsinki"
}

# system type - debian-12
variable "system_debian_12" {
  type        = string
  description = "system image - default debian-12"
  default     = "debian-12"
}

# CAX11 - ARM
variable "server_cax11_arm" {
  type        = string
  description = "server type - default cax11 ARM"
  default     = "cax11"
}

# Datacenter name
variable "datacenter_helsinki" {
  type        = string
  description = "server datacenter location - default helsinki"
  default     = "hel1-dc2"
}
