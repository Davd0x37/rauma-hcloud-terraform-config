# Hetzner Cloud Server Deployment

I've spent some time learning Terraform and cloud-init to automate the deployment of a Hetzner Cloud server. Mainly because I wanted to save 5 minutes of manual configuration on a server that I will create only once and do nothing with it.

## Disclaimer

**Use at Your Own Risk**: This configuration is provided as-is, for educational purposes and personal use. I am not responsible for any misuse, data loss, security vulnerabilities, or damages resulting from the use of this configuration. This was created solely for my personal learning and to automate server setup. Please review the code and adjust it to your needs before using it. I have no idea if this is secure or not, so please do your own research.

## HCloud CLI

There is better way to manage servers - just use [hcloud CLI](https://github.com/hetznercloud/cli)

## Description

This configuration will deploy a Hetzner Cloud server with:

- IPv4 (disabled auto_delete)
- IPv6 (disabled auto_delete)
- Firewall for SSH (custom port) and 80/443 ports
- Two users (admin and maintainer) with SSH keys -> maintainer can sudo without password
- Hardened SSH configuration - done by cloud-init (maybe by Ansible in future?)

## Prerequisites

1. Hetzner Cloud API token
2. SSH keys for admin and maintainer
3. Source IPs for firewall rules

## Links

- [Terraform](https://www.terraform.io/)
- [Hetzner Cloud](https://www.hetzner.com/cloud)
- [Hetzner Cloud API](https://docs.hetzner.cloud/) -> Everything you need to know about server types, locations etc. is there
- [Hetzner Cloud Terraform Provider](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs)
- [Hetzner Cloud Cloud-Init](https://docs.hetzner.cloud/#servers-create-a-server)
- [Terraform hcloud provider](https://github.com/hetznercloud/terraform-provider-hcloud)

## Deployment Steps

1. Clone this repository
2. Set up your variables file (choose one method):

   ```bash
   # Option 1: Copy the example file
   cp env.tfvars.example env.tfvars

   # Option 2: Rename the example file
   mv env.tfvars.example env.tfvars
   ```

3. Edit `env.tfvars` with your values:

   - `hcloud_token`: Your Hetzner Cloud API token (get it from Hetzner Cloud Console)
   - `base_name`: Server name
   - `ssh_port`: Custom SSH port (default: 22)
   - `ssh_key_admin`: Admin's public SSH key
   - `user_name_admin`: Admin username
   - `ssh_key_mantainer`: Maintainer's public SSH key
   - `user_name_mantainer`: Maintainer username
   - `firewall_source_ips`: List of IP addresses allowed for incoming traffic, example:
     ```
     firewall_source_ips = ["xxx.xxx.xxx.xxx", "xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx"]
     ```

4. Initialize Terraform:

   ```bash
   terraform init
   ```

5. Format Terraform files (optional):

   ```bash
   terraform fmt
   ```

6. Deploy the infrastructure:
   ```bash
   terraform apply -var-file=env.tfvars
   ```

Note: If you use a different name for your variables file, adjust the `-var-file` parameter accordingly.

## Server Configuration

The default configuration in `variables.tf` uses:

- Server type: CAX11 (ARM-based)
- Location: Helsinki

You can customize these by either:

1. Modifying the default values in `variables.tf`
2. Adding new variables for different server types or locations
