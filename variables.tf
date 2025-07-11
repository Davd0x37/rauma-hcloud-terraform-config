# HCLOUD token
variable "hcloud_token" {
  description = "Hetzner API token"
  sensitive   = true
  type        = string
}

# Server name
variable "server_name" {
  type        = string
  description = "server name"
}

# Server base location
variable "server_location" {
  type        = string
  description = "server base location - used only in naming"
  default     = "helsinki"
}

# system type - ubuntu-24.04
variable "system_image_name" {
  type        = string
  description = "system image - default ubuntu-24.04"
  default     = "ubuntu-24.04"
}

# CAX11 - ARM
variable "server_type" {
  type        = string
  description = "server type - default cax11 ARM"
  default     = "cax11"
}

# Datacenter name
variable "datacenter_id" {
  type        = string
  description = "server datacenter location - default helsinki"
  default     = "hel1-dc2"
}

# SSH port configuration
variable "ssh_port" {
  type        = number
  description = "Custom SSH port"
  default     = 22
}

# Users configuration
variable "users" {
  type = list(object({
    name                       = string
    groups                     = string
    ssh_key                    = string
    identity_file              = string
    use_identity_file_for_root = optional(bool, false)
    password                   = optional(string)
    sudo_nopasswd              = optional(bool, false)
  }))
  description = "List of users to create on the server"
}
