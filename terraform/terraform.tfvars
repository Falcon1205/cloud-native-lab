proxmox_api_url      = "https://proxmox.lab.local:8006/api2/json"
proxmox_token_id     = "terraform-prov@pve!mytoken"
proxmox_token_secret = "f17fb024-21ca-4cca-a7b3-5ee47e4cc6be"

bridge  = "vmbr10"
gateway = "10.10.10.1"

ssh_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIML1sFxiALLaG2sv6pIgHwRKllpOoVxEwlZIDHYlDLnQ terraform@lab"
template_name        = "template"