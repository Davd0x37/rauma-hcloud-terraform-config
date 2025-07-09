# Admin account - root alternative i guess?
variable "user_admin_name" {
  type        = string
  description = "admin account"
  default     = "admin"
}

# Admin password
variable "user_admin_password" {
  type        = string
  description = "admin password"
}

# Mantainer account - user with privileges to manage the server
variable "user_mantainer_name" {
  type        = string
  description = "mantainer account"
  default     = "mantainer"
}
