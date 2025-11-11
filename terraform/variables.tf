###############################################
# Proxmox API Configuration
###############################################

variable "proxmox_api_url" {
  description = "Proxmox API endpoint URL"
  type        = string
  default     = "https://proxmox.lab.local:8006/api2/json"
}

variable "proxmox_token_id" {
  description = "Proxmox API token ID"
  type        = string
}

variable "proxmox_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}

###############################################
# Networking
###############################################

variable "bridge" {
  description = "Proxmox network bridge for LAN"
  type        = string
  default     = "vmbr10"
}

variable "gateway" {
  description = "Default LAN gateway"
  type        = string
  default     = "10.10.10.1"
}

###############################################
# SSH Access
###############################################

variable "ssh_key" {
  description = "Public SSH key"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

###############################################
# Cluster Options (Optional)
###############################################

variable "template_name" {
  description = "Name or ID of the template to clone"
  type        = string
  default     ="template"
}
